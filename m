Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3338606A331
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=GSunXXBe;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=qzyA9XRp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEA410F023;
	Mon,  9 Nov 2026 05:16:41 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9ABD10F023;
 Mon,  9 Nov 2026 05:16:29 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A958AF41800571; Mon, 9 Nov 2026 05:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=E+Z+qFK8Y8vbo4Ex+NtaoiTKKpT5yrfUO/5tj1ZLrI0=; b=GSu
 nXXBeZvVMkPweVQ+3eLa/jWHhFrtxeeLRzIYKR4gsn54nKW7Wcy1/qiuK7M3Lfr0
 LCBtesQg+J373Tu2/apkQtBmopJi6B/+gg8EH29baSaDuINDJXpuej9afrTT5Vpl
 YLvnAij3RYIa7GdchmvSoJhfeUS0OOnbr00uLMVFS7ULSfImVXHYqBPP2AG/CmW2
 3OxE5rTYEpad+BzZMd2ru1D9P567zHdHunO6AVju3009VX7lui1iJ+8yqn0zcmYj
 jsHAxJYmEabaNl37FiPEQxLfhr8MfSaRQ7LE6w00QVC6NmCp8rSKfvGBqD/DpnzV
 FfJaXWEHEtdo96IDJEg==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021128.outbound.protection.outlook.com [52.101.95.128])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx18gx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Mon, 09 Nov 2026 05:16:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGM8iuV+UCYqBwSBLd0T2QbrOSS4sXRYKxqM51XSqAY8YDRNaixpwf5+XDr2bqZxDHaW5f+adTKY0pmaPX9L5E33Gojm9MYmr2AbqCQ3Rq/iWoajfQ5mVdysG2Mq2wtFlwqo7/shWBdC9hcO0RMWSJAOnSrCb4/g5m07UWgdlKVvQp6LzFCYK9d2CmTfrAkj2etslTr8r0wajweS5XnVicuiykHNlEq5mL9j/fU82tyfES2BmAmubgwdbcPqsd696E2TyclJG+XbUdkP2MrHrd/lf6mfqEo8byB7+3mbI2Dqtqfe3F4zzBTCSrjuO+sEt3gD/oHz2LKU9vB0DL0ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Z+qFK8Y8vbo4Ex+NtaoiTKKpT5yrfUO/5tj1ZLrI0=;
 b=xi6CXAI3TjuJqrvhLduBOuzmFBBg3nq9kz+kH3zI93ty1Vqs/hc5UgzmcdfGuqY4MeDBnQdL12ygIiTdy11BlSn9r/wkm21rtaTE2Br3FKn3QdSJ3yCVBJLsz8klYRfSF8TminFECiBG1/PKaDTB1VvqvIQO4zGmO4MiCR/BrwvYnQlSFw5CFuSJrCH+q9jdqI9CYiiEZy9shtE9XhGhu5ubLeAI4guSErqzD/Ix7yMHHfhf605iT7GtcbhGmadQLhdaPt157ruDij/qbi2S5KVDsPQFimmhv+2Z+COsheSQjdrGn8G3UM1b4l0x7Zr3WekXR81Wl5iBBeuJudNndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Z+qFK8Y8vbo4Ex+NtaoiTKKpT5yrfUO/5tj1ZLrI0=;
 b=qzyA9XRpOx6guUJm18dyRoCmAIzuQrbpgM08Li7PwPNYsVvmjaG4GMMbkFA5PpWAuwCMzwJqr61fYiBLkgnBKB3qmJ/ztZXeoq0zZDpLq46KGn1k9XUnR+B3O7s7LXNAbq3K+//SU6JV6rPkWHGveZovaeE5eDildXqrsVgL50g=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LOFP265MB469462.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:705::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:16:08 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 05:16:08 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "pjw@kernel.org" <pjw@kernel.org>,
 "alex@ghiti.fr" <alex@ghiti.fr>, "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "opensource@mtcoster.net" <opensource@mtcoster.net>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] drm/imagination: RISC-V and META firmware
 interface updates
Thread-Topic: [PATCH v4 0/5] drm/imagination: RISC-V and META firmware
 interface updates
Thread-Index: AQHdcAls8U4gjmf0MkOg7NFzeoTFmw==
Date: Mon, 9 Nov 2026 05:16:07 +0000
Message-ID: <651cb4c2e4bb7568d6dea4c7b0dd8fe44b783a99.camel@imgtec.com>
References: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
In-Reply-To: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LOFP265MB469462:EE_
x-ms-office365-filtering-correlation-id: c56779a1-9b97-409a-69aa-08df3e208f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|921020|38070700021|56012099006|261021121427099003|261021123027099003|261022115727099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: E2dMrzBHOnp0kJP3kX6m+QTTpnJZHxsEohpssGVWTcjG4pKS3QY19N9Xe2m5euqsO12eIqV7dACoO1zNCpVYOzjDKPwh4KvesEBN5PZMFdXpI+LzZhshODYZtbWkcBEPSrMSOpZ5ZLhyQ/WiGweZGcxFmoI1VybINB90B3jVYVhvKVOwCaJ/FrV0JITIxb7uklv9jEiitzB5rKE+Xym1nGsHfCpe9DTevw3XqmyuuhPBZHq/KI1oRYDY8NumRg7bJbXsj14T/qgPchOZNye3Ae+MJ9hJsgrlr6KxPdEwN+rATSPP9HrdpsnCjtOhl+85Z9N4yVgfrXhuJWAt1mnms82L3IVYFW0t1eFZYKjlIQkfZaMnVkSu4nTKiPan6sQHD9yqAB8YJrVBw8TniwxzH3O9/rYWl65C7cD403N6MAG4tP8lCqL9OCUcaVehr/iqP63hgYiG8eo5qGOWo4xnoUpULB2Nru7kPrVxJYSTo6EHdiFFv4BnjmTVk2We2EtbISZriX0RbChn9I/qg2HuyOUg82kc04QxED63Leg72sb32bFQo8Rah1aSPpOn/6VWwQ1CzAshksDxh1ZGG3s+ZtzM/EgnHnMX6cUDOBNXZqUeTdxPHWP7YGrYqstG7GVYao1gUhZ0N2aiawdhab4Q9awavs61jvBOUq8iJ3Lnft2O0XTVwl7Kfz18ltPq9S4V
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2Y0SmhpUVJvNmxOdDZUNk12cW9kVFk0eHJFVW1qU0hNZzg3Qkp6WnN3a2dh?=
 =?utf-8?B?WGtwcHhya2hKRTErUGtFQnlkZlNzQlBWQythZTJVRmVxOVhraHhvaHA3eDhV?=
 =?utf-8?B?dVJqZjBGNVllU25sb05ZQWVlaVNpS1dTU0JRRVQ3TlEzTXBsbEdlUVFyTk5W?=
 =?utf-8?B?TDZhYTRtWEMzelZ1Qk0yMndHSVZyNm5PajZORXlGdEZYRWFGemtscU5ZTXpT?=
 =?utf-8?B?NXRGdzFpWmpFUnJIL09xZldTNW5WVjVCWUplWjROamFlTjZrSXpHeW9Md3JH?=
 =?utf-8?B?RzF4NlZURHlKc3YzUmlLZjZONzRJb0tsNWtxaHRpWmpZMUtrOGpCWG9adS90?=
 =?utf-8?B?OHZXSUNBcnBGTTVuSmY4THNNd0N3b1J5dlhXVk5BNjZPMW9vZnh2MW94Q2cx?=
 =?utf-8?B?RkJxVldOcndxcU5oTE4yTHN5RSsreThwTVpmWklUM1NPWDloSzkzcWVEY0ZH?=
 =?utf-8?B?VDVwb2d0amN5OGlURVRHTkxIMHdTaS9mUDVabTBaVTcwWllwV1MyUW43MWM3?=
 =?utf-8?B?ckljaENBUG9kTUNCNUdqRmp1ZFd4K3NucVNHazB2UnVFY0YwcUl6aHhsYlhB?=
 =?utf-8?B?RVBPWjJsL29mR0IySFR6LzR5cUQ0S090OHk5L0w3Mkp5WVpiVnBiMHRUaFZE?=
 =?utf-8?B?aFRkNkRFU0o0TE54ZVpRY01UR1VNV1V2WnF3WEpxOU5qSUtNOTBiaTZNYXZD?=
 =?utf-8?B?dGZadWlxN0g1WENXT0QyanAzL0I1U1VzblJVOGhwSVNic09HMStwYUI0VGY3?=
 =?utf-8?B?REQ3cVBWSVluSnBMUU9SaXk1bGZIWUFTOHhsZVF4QURpM3h4UmNhWjEreTJF?=
 =?utf-8?B?OS9BOFg4d2daUGlJYitEZHJTdXlkOUlnNkR4akxhVEs2dmVsd0V2THNNOERz?=
 =?utf-8?B?SmRXK1J6WFZIdlRRWngwSkwvWjJKWmhoZnRuYko4SVVRWjUzRzlVSGZxckJq?=
 =?utf-8?B?YXRBcVphMVhRQUc3L0tBZEM3V0lVSlZablpsWndwemRzUVQyNDVTZmNtZm83?=
 =?utf-8?B?MEpJNkw4aDBjZHBDalA4WUZoSUNtSk9hRG1rU09iRjRaYTBkWURUd0tvV3R1?=
 =?utf-8?B?bkR2MlhnMkUxUnc1R2RENkVSak92QmNrY29QMG4vTzRjSDdqUEN1Zit6NWhJ?=
 =?utf-8?B?UFcxWDVndElFZTlBZ2oxUVI5ZkJjL0diU1RtbE85bGxNdEZFU25lNHNURXpN?=
 =?utf-8?B?STdkMU02YlBCVCtYak1iUFY0UW1aUUQ3YWUyLzFwU2piZzd0dlQyUUtaTGR3?=
 =?utf-8?B?aUIyRVhmTnZkY0FUdWVSMXZuWHp5VXRZMFArT3gzeU9nL1RIdzNSMnBoVitD?=
 =?utf-8?B?WUxsUDVaOWJOMXJ0Wk1OaGlhU0hsZjdNcld2YXBZNTE5RWwxYTAwTUFUU1Fu?=
 =?utf-8?B?eXpqcG1RajkxdVNja2swaFFtcDhrSEV3V3Q5b1NuYTBvbFlvUkdvNEM1Zk9K?=
 =?utf-8?B?VytzOUNlbHliNWZIYXJmZGpudEI1KzNEdWE3RFV4TURMa1lOa1NrWlh4VXNK?=
 =?utf-8?B?bnFsNDFtOEF0SlFZM2RBeVI4eE9BQkZpNE45VVg2bkowWU5PUlV4RjFCUDBQ?=
 =?utf-8?B?bHVwS1hDZ3VpZmZmMyt3YWtWdDBrS0dUVlpOalhXYUVhaFhlb0tYdFo5TFJ3?=
 =?utf-8?B?ZkNPOGJ5Y1N4SHJVdzAyMVRaV2J4c0FEOVZBU2FIMmkzdlNpN0ZFaUowKzRG?=
 =?utf-8?B?cHBTaVdqeWI4bStHYzBEUmxFTml4MVhJWnJIL2E1bXVrUTY2Y2M1WG0wU0VC?=
 =?utf-8?B?UkVrY3h1Q1pCbW1jcXU3cURvOGV1STF6QStWMHhLZ0o2TUVtZW1CZjFtV2Iw?=
 =?utf-8?B?VWljd3JzdXVITUdBOVEvbFRLbGd5Z1RNMUZxQ0lCWm5yRE9DazBxcHI1RE1j?=
 =?utf-8?B?WDBrc0NFRUtwM0hkUm8wcmpVRHExWlU1Q2IrR2JTYkZJWmlYelVjRS8rclRD?=
 =?utf-8?B?bDBxdGpjTjl2S2VWbG9RZ3djQVZZazZ6VE5NUHZPT2hoTEV6L3hpdWZIcE1s?=
 =?utf-8?B?dHhmNmpncEtGVXpOY2hDZ2JlOWxUY2padnJNN3hZNG1IdHppSklhZjJ1UDVF?=
 =?utf-8?B?dzhmWVZSNnIzWWVtYjN1MWdHN29IQm1sUFd2UjAvUms1MVNoWWlGbjYzVkNq?=
 =?utf-8?B?ODd4bm5Db2xJYUdlNStEMGdlcHdHcEpJNlVJN0hndDEvcXA4b3J3VFR6WDdF?=
 =?utf-8?B?czZkUWQ3bThzemdRZW1QaTRSNW9tb0UwSzBpcU5FMFJwWERuakJmZG0yRVpV?=
 =?utf-8?B?bE4rOWFneTdKRVlzWFNZOXphQTNBVlFaYldKazFIQk9hZmdMYXcyenYySmdV?=
 =?utf-8?B?Smp4QVI4K3J3OWRVdEVha3dscUVYSytXdDN5aUUyaExpVHorbGU3RktKUWJn?=
 =?utf-8?Q?Ryh7/mXwHfVHQr3CajCGaLxZKPkQYN9Gf+RJogwJ1AFoL?=
x-ms-exchange-antispam-messagedata-1: ux9Rdzn4qtR52DwX3x0AgMEdgifIxCmztRw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF47A29D90ACF54799EBFEE94594E605@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4x49p91z6LyvY7rD9e+tsgN8nM8mlt+kgH72KPFmsjcIOnRZzVgVg7jSPZW1UGe5N7XQV4OCkziJIPZGgd7jv2HbjGTtFmdXlSdHFCINgxhBK+esUCrBP8DofZ30cAA6lSph284CnrCsue/wrwoksDKLcP8p6Ii9EGbQM91LHCV5ygoQraE+Y3eYkUxE7KdFPNroP0Gp8i+H6jqgDQPDAUTI5Eydeh6GAJEhED/Rro+MFHEcQUzxJuDuM07XN33BkEMSBuLDgAi9DM+ZIwceHnnCUId9lDjQsO0ktyBDdU9nxN4fpqA5KDr/nSymTCzo2UcEIjngGcUMBKsu6G4pig==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c56779a1-9b97-409a-69aa-08df3e208f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 05:16:07.8180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKJg/L0XSvakKglec8g5RCxfC2rRmmEIOyNRZuHoxW5fV1dTq3/Ay9mzQCKzq1s98GYf8ofHX6f3aMi+TbywH0hBQNwIibO+iE3UwYRECa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOFP265MB469462
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX1HjZ09RnkO90
 i4hMnGpEu1GsoUXgDEg5p4Vap0M+VLAQvhWtMKcJAwUgbs4cy2T136Spc1sTYVMlzL4qfzyKeHY
 zqkPo0hajV4mrPZlnyLVGy5o7v1FGe0=
X-Proofpoint-ORIG-GUID: djoisqfMlc1gGi24wBJct7q5FH7uDr_e
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af1571a cx=c_pps
 a=GYKJVqjP5HEJ3kJlCgcxTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=XWCimdJHYoRkDFDAc14A:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
 a=2TKV-7w1aU1AVAwN0oqT:22 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfXxpKrlKZUUvLa
 bWLOtexwgNxmP2YRMZiWb93OTfb2nYDE2vIZmV2Bt400aDoI8+P/lbA5jdvqbywV/SH8dSCtbdn
 7xd6bmdyTBC2l+7aRE4i3k/zkTyZ5dBGKO6nqq/OeQr1eyzTBzczQGqrAbXP7Pk8M4qakLJL1CL
 BAv/uYw+P9orQMaEfbl68rjiaHPIAM+XwWTZE7/FymjyKfQa9UiZb2YhVtFhe1ofc/jTyiUtZeu
 FikEfKnq1mA6jrHSAOegmnv8qdlNUleZANfRw+lghHleYvVBvhfGXflnGwWe1bfbmoOVNZP6+Wf
 hPPE6ynf8ujIHKzGeSG07jrfnYEp54ilQuQe7tgSWneQOFVq2SL0dM1axO6rR7pLUCh5g7maRZ/
 zxssuA+kNr5Z4Pv/kSnfv42uV5Uua4kETirr5vzQHXIeRu9ztNo+cJITXjTrT+BdkBPy6U8GcpM
 mtqpw38VgAADKl+8Zhw==
X-Proofpoint-GUID: djoisqfMlc1gGi24wBJct7q5FH7uDr_e
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTExLTAzIGF0IDExOjAwICswMjAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IFJlZmFjdG9yIFJJU0MtViBhbmQgTUVUQSBmaXJtd2FyZSBpbnRlcmZhY2Ug
aGVhZGVycyB0byBoYXZlIGEgbW9yZQ0KPiBnZW5lcmljIGFuZCBhcmNoaXRlY3R1cmUgaW5kZXBl
bmRlbnQgYXBwcm9hY2g6DQo+IDEuIExpbWl0cyBhY2Nlc3MgdG8gdGhlIFJJU0MtViBhbmQgTUVU
QSBmaXJtd2FyZSByZXNwZWN0aXZlIGludGVyZmFjZXMuDQo+IDIuIEFsaWducyBSSVNDLVYgYW5k
IE1FVEEgZmlybXdhcmUgaGVhZGVycyB3aXRoIHRoZSBvdGhlciBwcm9jZXNzb3INCj4gaGVhZGVy
cy4NCj4gMy4gQWRkICJfZndfIiBjb21wb25lbnQgdG8gdGhlIGhlYWRlcnMgZmlsZW5hbWUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVj
LmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gRml4ZWQgYSBidWcgaW50cm9kdWNl
ZCBieSB0aGUgcHJldmlvdXMgdXBkYXRlIHRvIGxheW91dF9pc19tYXJzKCkuDQo+IC0gTGluayB0
byB2MzogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYxMTAzLXByZXAtbWV0YS1mdy1hcmNo
LWluZGVwZW5kZW50LXYzLTAtNTYzZGJhZjFiNzc5QGltZ3RlYy5jb20NCj4gDQo+IENoYW5nZXMg
aW4gdjM6DQo+IC0gRml4ZWQgcmVtYXJrcyByYWlzZWQgYnkgU2FzaGlrbyBpbiBwdnJfZndfc3Rh
cnRzdG9wLmMuDQo+IC0gTGluayB0byB2MjogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYx
MDI5LXByZXAtbWV0YS1mdy1hcmNoLWluZGVwZW5kZW50LXYyLTAtYjlmNWQ2OWI3YTUyQGltZ3Rl
Yy5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gVXBkYXRlIHRoZSBjb21taXQgbWVzc2Fn
ZXMgdG8gYmV0dGVyIGRlc2NyaWJlIHRoZSBjaGFuZ2VzLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBz
Oi8vcGF0Y2gubXNnaWQubGluay8yMDI2MTAyOC1wcmVwLW1ldGEtZnctYXJjaC1pbmRlcGVuZGVu
dC12MS0wLTczZTExNmYwMjE3MkBpbWd0ZWMuY29tDQo+IA0KPiBUbzogQWxlc3NpbyBCZWxsZSA8
YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KPiBUbzogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2ku
c2FudGl2ZXR0aUBpbWd0ZWMuY29tPg0KPiBUbzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4u
bGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4NCj4gVG86IE1heGltZSBSaXBhcmQgPG1yaXBhcmRA
a2VybmVsLm9yZz4NCj4gVG86IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRl
Pg0KPiBUbzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT4NCj4gVG86IFNpbW9uYSBW
ZXR0ZXIgPHNpbW9uYUBmZndsbC5jaD4NCj4gVG86IFBhdWwgV2FsbXNsZXkgPHBqd0BrZXJuZWwu
b3JnPg0KPiBUbzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gVG86IEFs
YmVydCBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1Pg0KPiBUbzogQWxleGFuZHJlIEdoaXRpIDxh
bGV4QGdoaXRpLmZyPg0KPiBDYzogaW1hZ2luYXRpb25AbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IA0KPiAtLS0NCj4gQWxlc3NpbyBCZWxsZSAoNCk6DQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjog
TGltaXQgYWNjZXNzIHRvIHRoZSBSSVNDLVYgZmlybXdhcmUgaW50ZXJmYWNlDQo+ICAgICAgIGRy
bS9pbWFnaW5hdGlvbjogTWFrZSB0aGUgUklTQy1WIGZpcm13YXJlIGhlYWRlciBhcmNoLWluZGVw
ZW5kZW50DQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjogTGltaXQgYWNjZXNzIHRvIHRoZSBNRVRB
IGZpcm13YXJlIGludGVyZmFjZQ0KPiAgICAgICBkcm0vaW1hZ2luYXRpb246IE1ha2UgdGhlIE1F
VEEgZmlybXdhcmUgaGVhZGVyIGFyY2gtaW5kZXBlbmRlbnQNCj4gDQo+IEFsZXhhbmRydSBEYWR1
ICgxKToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBQcmVwYXJlIGhlYXAgY29uZmlnIGhlYWRl
ciBmb3IgbXVsdGktYXJjaCBzdXBwb3J0DQo+IA0KRm9yIHRoZSB3aG9sZSBzZXJpZXMsIA0KUmV2
aWV3ZWQtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3VwdGFAaW1ndGVjLmNvbT4NCg0KVGhh
bmtzLA0KQnJhamVzaA0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jICAg
ICAgICAgICAgICAgfCAgIDcgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
ZncuaCAgICAgICAgICAgICAgIHwgIDI2ICsrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9md19tZXRhLmMgICAgICAgICAgfCAxMDQgKysrKysrKy0tLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X21ldGEuaCAgICAgICAgICB8ICAxNCAtLQ0KPiAg
Li4uL3twdnJfcm9ndWVfbWV0YS5oID0+IHB2cl9md19tZXRhX2ludGVybmFsLmh9ICAgfCAxNzUg
KysrKysrKysrKystLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X2Z3X21pcHMuYyAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX2Z3X3Jpc2N2LmMgICAgICAgICB8ICAxMyArLQ0KPiAgLi4uL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX2Z3X3Jpc2N2X2ludGVybmFsLmggICAgfCAgNDMgKysrKysNCj4gIGRyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfc3RhcnRzdG9wLmMgICAgIHwgIDYxICsrKy0tLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZ2VtLmggICAgICAgICAgICAgIHwg
ICAzICstDQo+ICAuLi4ve3B2cl9yb2d1ZV9oZWFwX2NvbmZpZy5oID0+IHB2cl9oZWFwX2NvbmZp
Zy5ofSB8ICAyNiArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVf
cmlzY3YuaCAgICAgIHwgIDM5IC0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX3ZtLmMgICAgICAgICAgICAgICB8ICAxOCArLS0NCj4gIDEzIGZpbGVzIGNoYW5nZWQsIDI4
OSBpbnNlcnRpb25zKCspLCAyNDEgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDog
NmUzNzVkZTk5ZDBjNDIwMTY5NDgxZmNkMzYwNjQxNzdhYjU1YjA5ZA0KPiBjaGFuZ2UtaWQ6IDIw
MjYxMDI4LXByZXAtbWV0YS1mdy1hcmNoLWluZGVwZW5kZW50LWZmZDZkY2Q2MjZkMA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiAtLSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBp
bWd0ZWMuY29tPg0KPiANCg0K
