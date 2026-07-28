Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A103C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE66810E9AA;
	Tue, 28 Jul 2026 18:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="HP1eAMTj";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="dHwAcv8E";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76C010E9AA;
 Tue, 28 Jul 2026 18:04:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SI4Mkr3032592; Tue, 28 Jul 2026 19:04:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=5612TG1V3GOkViH5Bb88HH+ftxEuk81+UjvJVY+ml5A=; b=HP1
 eAMTjO70uHITfdsg3yTy1It5dj57d7jJr+P0P9txrWgdQ7ltBiztKomKFuk+4kT2
 u8WawtN/m8tXYXCcAi17ukUUZLrVFqn1LeXZwXQbEnKDzTS2CmAyH5QLpl/UvFpr
 t44U9VUetUyTiGRas4wgoLcObpTSt9d5xRwV5kqyMxOzXqqQAjQjrvokkEeArSXX
 6M5nL7jvnfT9u42AOv0nSxXRGsoMzsPSk3vkcNo+HQVpK0QN2tweJFVqav76Ulgh
 NIc8+RzJLdWZGTzfv4vXiHKvuQYRP1TR/qNEzH97C/tF0b//IDvkW7DPNCeE+ZKJ
 PsPYJnDOnhCQJ18H1eg==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020121.outbound.protection.outlook.com [52.101.195.121])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fmn7s2ygv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 19:04:22 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N95/O/UMDOoqHbD22vVfUFMJwotPSofpQxy5IDRAQZQ0Ki7DgN3ubBcwEBzKpQjQn7K3GVMyO0mH6rkQFeGgxBklnKJjVHtsePdFjeOCChut8uegBV1vXDTRt3zMR7EfsMJXPVCHGGuM53uW2PKlMq84MONU5JbFXFU6woP/Xy/mooi7Cv+vajt+PbxFbpyIZDzPf2dCZNqjSkSe8AXgU1oqZwOO1iF0HAgmCZuyxamUEH/tW2BV38uPvcEVSQ2wwyuqztBbmB1s5vZw28mplSPmojwfZJdtCA00gDhc1Wn7uo8Rwnz5kZjohVFbGkB7xNHyz/vjiQV9X70D2isgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5612TG1V3GOkViH5Bb88HH+ftxEuk81+UjvJVY+ml5A=;
 b=T7zi5ra2+a/ntUPWLJQmMbuOGWiZTw6WbYFIjLOd1SSfz6D+az//OY5vjJ6cuMiiVvFiAt3NLXn6ZsKWLUQYbOm2GITX9GIWhOBf0GXr0S6FQomaXa15qVqg8Ao2rpIE14NKkiKlCzWha0j0b1w5/zZ5PoAGaw+2pAGzFEMyLpo+GcgVrNQvJWPFrzXvWaIRymtEWU1Yq7jTlxE4is66dltRpxOYP5wB4LYhDckSKDYWrUutfEhpSn3xbkm551Ig025RfxHFHepNCb+zzcbDbk98hoMVF8H4HEDEsdCrXs57CuoMaIgejGwyfrkrcLgASJJBpTkm77sGXNVz/Yr+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5612TG1V3GOkViH5Bb88HH+ftxEuk81+UjvJVY+ml5A=;
 b=dHwAcv8EkvodcjTY8HoMKiLFvpYnWCnK+fBebWnGV1LP/Q5e4cXwYElbq4UjvnnBmEuP+djgo+1B3mVgcI7iF2QIb/cAcio8EcSb9HJtDNSI47M20OtgmJE+vwzON91VeTLM7UCurajh5mukFYGsbuPcm1eQjZGgGpuVow6e8uE=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO7P302MB2268.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:450::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 18:04:19 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 18:04:19 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v3] drm/imagination: Update the trace point
 pvr_job_submit_fw()
Thread-Topic: [PATCH v3] drm/imagination: Update the trace point
 pvr_job_submit_fw()
Thread-Index: AQHdG3qteI+ArpYW0E2un0qE6LZ8xraDQA4A
Date: Tue, 28 Jul 2026 18:04:18 +0000
Message-ID: <ce5568dc8bad2c21a172a515dd3813dbf5b99ca3.camel@imgtec.com>
References: <20260724-b4-tracepoint-fix-v3-1-8f8e5e8179d3@imgtec.com>
In-Reply-To: <20260724-b4-tracepoint-fix-v3-1-8f8e5e8179d3@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO7P302MB2268:EE_
x-ms-office365-filtering-correlation-id: af80c0cb-08fb-4d4b-6a9c-08deecd2a51a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 4Wqkc8+eYvjPK3ddVGlRntTiMxgZt13Ssdd+HmN7ugC41MZHisN8RhETOCXDuRoDO0mLFiZioS+ttPORyaDXtNWcLwAYz79BYDoQfECnHl7pDAhNlBYcpWrYEhQamq929iEyuYADdAvrZL6g2iz8hhrN+TyFzJIvTDTTpxQ3+CbViGTgAE5Db0U/1C7LMpaYcwPrj6V+LTCZdNNUUVZZHwcbE9jKdRJFFVeg5eX125Iwq86Tb0PZY3UXC100A2vlKbhAbiN47UDPZeGkqWHg1b8kPeLGXS8PXkT0xyhOJzcNAOrzK5hGT9DlRIIYt/T6Mg59uY8qRmhueaqaLUEPGV5lVL1gRnernxWWaj+oNWQ4Xb5E0SzfeCacAtyMtVrw74R0+s+lg5zgvJriWl/7isMIK7HA2sKwcHIjYH/yx+084yaa0ZNxn1y+oCQeg6zq9NfZm6d5twmGL2AnLjYQ0sO7/e/K9rO2REikG8aJnkYNekw2iYdPf20OVi/cqt8qmVnIZyqLgEBA30qkGeN/LEq9BEcRbZB3MfMYQ2NnG9RIIOcAK+nWZghRmy06om1+6cLycHclPT88+7+rvW/AKiZAPa3FZ/89rTVdPCU5RNYzlhdSrCwkmd39hg1gfhg9kB/jbX89Njpi8EFJR8r/CWB0oDNttiNXxOzAAeLc6CnZNrtlRZCSh5961FPfma8UpdiqqOODfx1f8aBjdA8ExLGVv06q2bzJpQfUDfXF5TA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWd6TWUreHBYamVwNU5yWUpYajJDYXEyZ0NxN1NTcnoyMkhEZC93RmlOOFFw?=
 =?utf-8?B?RlBZZklUb0lrajg0THBsVkN1R3EvUUp2eXBFTGprWE05SGsyL1ZvallPM0N3?=
 =?utf-8?B?Qkl2R0xrSHA5MldQWEVFdkdud0J0d1huWFY0c1dDZm5rOTloRU9GQnZObmsr?=
 =?utf-8?B?NGhjdERpNkx2RjVsdVZKc2h1L1RzTmloWGRqTmpZc2VnUGliUWl0WlhqRndj?=
 =?utf-8?B?a0RyM0h0YWhFWWZyU0YvQXlra2ZIN1hvN3FIa1VHRncybUpOLzJHNHgwVVFV?=
 =?utf-8?B?d29ma2ltMTlYSzBFRHJuWSs0SWNIRGs5Q3pacDU2R0hQVWt2a1VxajF4UUV2?=
 =?utf-8?B?bnF0ejVXWEZhMHFOajJuUVVCb1hVNmY3L3FONnNlWXJITTVJakQrQnVIZDFk?=
 =?utf-8?B?SUwxVUNmMndhdTdkZXFaYUdKOCtVWm1vY1NrU1BKZkpLdkxYZ3FneHhmQVFv?=
 =?utf-8?B?L3QxWXR3MHpuSis1d3IydmtNSzNqRzBZbm5YQ1lkakplRlFGc0tDNG1kQllz?=
 =?utf-8?B?dnNUdGtPUVFrMlBUemhZbmdIUi8yL0dLVlU0NklQc0RqK0ovLzRWTlVobk4y?=
 =?utf-8?B?d1hXQkFwbWVjVzRjbnhnbmREUWZTc3kzMkR2REpORm96Q01YUm1TQTdET2hV?=
 =?utf-8?B?ZUQ3SUUzMUdMQys2WUNEekJ2VitvQ0o5dk5YaTlyVTBscmRhNmtEOFVnWjZw?=
 =?utf-8?B?ektXaUkyZFREUklwbzRFbVUrelFFTTNvandhdXNYT3l2amdubzZRRjhYMHY3?=
 =?utf-8?B?M0pHdU16dHY0VHZtdGsxSWlOZUVEUmcxMWE2cmUvYnZkS3BUM2lmRWpjK29i?=
 =?utf-8?B?UGtXYTdSVXhWZU5pd2tqWlZzOHlFTkgyczhWKzlRNlZ2eUlTUVY5RVFMcHZq?=
 =?utf-8?B?OWVKRi96cDI5akNSYlN6VTFhWThRV2VNVkZGYUN1eU1uOWpQTUdaNldCRFVL?=
 =?utf-8?B?Q2wwT29Xb0FqV3B6Yngwcm1sRUlSVCtFcFJaT0pEanhOSmFIS1laekl6bTl6?=
 =?utf-8?B?bnA4U1Zqakc4cFFkczBRZGxSck5jSDNIZHNNemo0TGErMEVySUpRNWZwVUIy?=
 =?utf-8?B?NWhGa3h0YUJmcUs0ZkQwS1RrdkVDOGhpYW1KbmdFOEtoR0ovU1NaVThjUllL?=
 =?utf-8?B?NDVPblV5OVdqNkVSL3Y0V2lHZ1FpRXoyK0k0a05SemlTSExNK1IrNVhEWDdw?=
 =?utf-8?B?UnBDV2ZoMTVIUEhlL09LMEhPVUVlVDhjU3Z6YlAzSjFXdDNlNWFDNk03aXNG?=
 =?utf-8?B?czJmV2lLZzVDUWRLQmoyM0w2cDc1ZVNGMmZJaVZxUm12NEdPMnJoT1JqelA1?=
 =?utf-8?B?eUQvNklFMWk0M0MxRTQ4cm1oK3lTVVZTQnErdDZSazJwVk1ScHRVb0REeFhZ?=
 =?utf-8?B?UFVHL0R1UnRDNHArL3lTWnJQaWdxakh4OGcyaVFwR0JVS3JiRitmajZ5V0Qy?=
 =?utf-8?B?czIzRnI1eUdZV3hBaFpJcktodFBCVytuYzNSVVdKbnNpd2g2Vk45TlA0RlNB?=
 =?utf-8?B?RDJMdEljRndwZ20waXJUQVFxd2hsNVh6b0lJVXVpU1pqUUg5MldKYmQ1MVU1?=
 =?utf-8?B?aEJlVjAwRUZOUjR3eVM5KytmWE11WFNHMTFZRzZYb0VpbzFuU0xpTGpZL2dN?=
 =?utf-8?B?clZBejRNTUw3TDJ3aHVMcjBJSW91NTZNSWVsN1BMYlpnQzRXVEpveS8rcEph?=
 =?utf-8?B?NFY5RmRjZFZDbWU5RkpXdXBPMHFML1R0UDdQa1Q0Q0dBdE1HTTUwWHA0Z1cv?=
 =?utf-8?B?TXZZWnJIbzVtNnJ6MVRNLzZzN3Y3N2FiZXBSU0RBREZFMi9SWXFkNUo1MUJV?=
 =?utf-8?B?WUdPRkRBcStsUkRidFEwVDRhT3YwUVhXTmRCRXF5QTVQVnlSK1FZL0N4RDlP?=
 =?utf-8?B?M1liS0VpWWgxT2l0dnFLZzBhRGdONU9VT202V2doL08zZmsydXFkbFBNQ0d0?=
 =?utf-8?B?dUVNMkxCK3YrVE5XalZScGU1OEJqYmFaeFJaekFvMStObmZUYzJYaEZmc3l3?=
 =?utf-8?B?R3pjVGNBdEg5eE1veGZzelYvVm4yQkIwVGY3UU5jZGJrTXJGdFp6UVJBRWxr?=
 =?utf-8?B?Z2ppbE9lMzJuQjdEb09BZms5bUgya0RLMFpkSzdkcnVSa1k0dTlNMVNReGJq?=
 =?utf-8?B?cEYybWVmNnlrODdYVmlPVEJvMFZzZGU3Z3RVMkFWYWNSZU1hMzMyM3pvMlIw?=
 =?utf-8?B?TE53SE41VlAzaEZvUUM1Rnc3NE1URWg5a2pETmEvd0RUcVI4cmNHMnRFK3V1?=
 =?utf-8?B?ZlJWL3N1S3JiWGxCdU82R0Nuek4rVzdFWUp2eFk4MVBUMjNDYkRHN1R5blNY?=
 =?utf-8?B?YTB2V1prN3pSVWlaWlBtdlVDTmI1Y0F6OXA2MFY5RXoyaWJuUUFQYzVkOE9X?=
 =?utf-8?Q?uWS62UoVkBNC/hN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7382E1C3CF607240A22EE2FA48D3221C@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q+Zg9bndu33bAB7Ucgdv+BrlZe+jcpC+k7zFrefnP8BbX9q6ymMXtJ1C7WNcfMx/5zgc0HgAUpKevfias8dgTAWKVBhJJwLz3VQ2qo+WDOPUP5Tvo9lIClOxGpPe/K3HpJA7D6WIry8zQg+TlXxWuQTSjGQNRMQNHnYPFd99WF1BJZjYd/1tQEMxx7keARQcZjtC7X72Qb2z1LRjn1HwmXKGbopwDZqCN1IuanOXD63DNhandMvf84eHrrkQMke2JILALiNq6LsCpaDcSsNbpOXq8JqjGdzn5cJqARV23zdzACl5GyteDzMSWNMqpICnSvFafQYnsE5L3DiTYFVI6Q==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af80c0cb-08fb-4d4b-6a9c-08deecd2a51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 18:04:19.0281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygZoo1E7mnHSh3j/jCFVRfSEmPyKs4FfQPI0LYYfG3HBFLyQ25cUSGq1/nZtzD987KVnRsRSfBcle6EQyujKGy68x2ybwG3wFvAY21xi8qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB2268
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE1NyBTYWx0ZWRfX3D1Z7gPgCALO
 C5vbIVV6al3VvrGgiR3gFqw3Cfw2PR0GFyNE3zotS5KkNfp7AzOAq+jOCCmisieiKjGvr0rimtk
 COBdXIDK7pfkLd2Wn7wnH6mVTvD/e7I=
X-Proofpoint-GUID: Ovgrrwt9QCvQwFQeCoXxScK-YGLiWb4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE1NyBTYWx0ZWRfX9NrGzbvwy7Km
 EM6nC3XqSZ2Ihl5DZxcHjkUY/orGT9Rsa6S2CYYSDPapAXjEjluerWPT53Kx2edW7XoRQFqCSK+
 7Zok2iyRnoN0nQtdJuyTPS+ziC4WIHCg31eNWEbOSPUZfTIpeuLotIIUHc5zT7liPSqP2DqMNNz
 h/fkwCGFihtrmslrzct10hKmpy6TLtN+163noQnqdmLQKyIpBin16Uk4xzruq9aLfVERbYmT3Om
 mddL+5bL1mQlUkgmN+GE9Qyz81AxXpzd6xXFCs1ex0vphZICW75yUqraslNCZMnBkLwLeXu4eEB
 XYFDfuTwjxkBuL4aroxYIV6JWE3fK2F5ijYeO7wceOr6DLA2o8Jus/zKFtxag1sLQCuQIyd/tdI
 5azcLTAwrWp974+5kR45hjv3XWK8wCAloLKGeFsEQlIoq25ID7hRegzRL0g9D9IiWUKbcwrY+tl
 uZfcRV+F91w8vXn5otg==
X-Authority-Analysis: v=2.4 cv=Fv41OWrq c=1 sm=1 tr=0 ts=6a68ef26 cx=c_pps
 a=jsnL9UUdHX4qT0ZunX9oFg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=xIT2i1UHaW23hUUcZHkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: Ovgrrwt9QCvQwFQeCoXxScK-YGLiWb4v
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

T24gRnJpLCAyMDI2LTA3LTI0IGF0IDIwOjEyICswNTMwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOg0K
PiBUcmFjZSBwb2ludCBwdnJfam9iX3N1Ym1pdF9mdygpIGlzIHVzZWQgdG8gdHJhY2Ugam9iIHN1
Ym1pc3Npb24gdG8NCj4gdGhlIEZXLiBDdXJyZW50bHkgaXQgaXMgcmVjb3JkZWQgd2hlbiBhIGNv
bW1hbmQgaXMgd3JpdHRlbiB0byB0aGUgQ2xpZW50DQo+IGNpcmN1bGFyIGJ1ZmZlci4NCj4gDQo+
IE1vdmUgdHJhY2UgcmVjb3JkaW5nIGFmdGVyIHdyaXRpbmcgY29tbWFuZCB0byB0aGUgS2VybmVs
IGNpcmN1bGFyIGJ1ZmZlciB0bw0KPiBiZXR0ZXIgcmVwcmVzZW50IGNvbW1hbmQgc3VibWlzc2lv
biB0byB0aGUgRlcuDQo+IA0KPiBGaXhlczogYzEwNzlhZWJiNGRlICgiZHJtL2ltYWdpbmF0aW9u
OiBBZGQgc3VwcG9ydCBmb3IgdHJhY2UgcG9pbnRzIikNCj4gU2lnbmVkLW9mZi1ieTogQnJhamVz
aCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpSZXZpZXdlZC1ieTog
QWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQooSSdsbCBkcm9wIHRo
ZSBzZWNvbmQgU2lnbmVkLW9mZi1ieSB3aGVuIGFwcGx5aW5nIHRoaXMpDQoNClRoYW5rcywNCkFs
ZXNzaW8NCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBSZXZlcnRlZCBiYWNrIHRvIHYx
IHZlcnNpb24gYXMgcGVyIGlzc3VlIGZsYWdnZWQgYnkgQUktYm90Lg0KPiAtIHYxIHZlcnNpb24g
aXMgcHJvcGVyIGFzIG1lbnRpb25lZCBpbiB2MiB1cGRhdGUgYW5kIGNvcnJlY3RseSBtYXJrDQo+
IHRoZSBzdWJtaXNzaW9uIG9mIGpvYiB0byB0aGUgRmlybXdhcmUuDQo+IC0gTGluayB0byB2Mjog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDcyNC1iNC10cmFjZXBvaW50LWZpeC12Mi0x
LWU2YTgxYTM0ODM5NEBpbWd0ZWMuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFVwZGF0
ZWQgc2FmZXIgdHJhY2UgcG9pbnQgcmVjb3JkaW5nIGZvciBmcmFnbWVudCBqb2IgdG8gaGFuZGxl
DQo+IFNhc2hpa28tYm90IHJlcG9ydGVkIHBvc3NpYmxlIHVzZS1hZnRlci1mcmVlIGNhc2UuDQo+
IC0gRHVlIHRvIGRlcGVuZWRlbmN5IGJldHdlZW4gZ3JvbWV0cnkgYW5kIGZyYWdtZW50IGpvYnMs
IGZyYWdtZW50IGpvYg0KPiB3aWxsIG5vdCBiZSBzY2hlZHVsZWQgdGlsbCBnZW9tZXRyeSBpcyBz
Y2hlZHVsZWQgc28gZXZlbiBWMSBzb2x1dGlvbiBpcyBzYWZlLg0KPiAtIExpbmsgdG8gdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA3MjItYjQtdHJhY2Vwb2ludC1maXgtdjEtMS1m
NzU3NDdmYTU5MWFAaW1ndGVjLmNvbQ0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfcXVldWUuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX3F1ZXVlLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX3F1ZXVlLmMNCj4gaW5kZXggOTQxYzAxNzM5OWZjLi5kMTM3MjY0MDFkOTIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcXVldWUuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3F1ZXVlLmMNCj4gQEAgLTcyNiw4ICs3MjYs
NiBAQCBzdGF0aWMgdm9pZCBwdnJfcXVldWVfc3VibWl0X2pvYl90b19jY2NiKHN0cnVjdCBwdnJf
am9iICpqb2IpDQo+ICAJCWNtZC0+cGFydGlhbF9yZW5kZXJfZ2VvbV9mcmFnX2ZlbmNlLnZhbHVl
ID0gam9iLT5kb25lX2ZlbmNlLT5zZXFubyAtIDE7DQo+ICAJfQ0KPiAgDQo+IC0JdHJhY2VfcHZy
X2pvYl9zdWJtaXRfZncoam9iKTsNCj4gLQ0KPiAgCS8qIFN1Ym1pdCBqb2IgdG8gRlcgKi8NCj4g
IAlwdnJfY2NjYl93cml0ZV9jb21tYW5kX3dpdGhfaGVhZGVyKGNjY2IsIGpvYi0+ZndfY2NiX2Nt
ZF90eXBlLCBqb2ItPmNtZF9sZW4sIGpvYi0+Y21kLA0KPiAgCQkJCQkgICBqb2ItPmlkLCBqb2It
PmlkKTsNCj4gQEAgLTgwMiw2ICs4MDAsOSBAQCBzdGF0aWMgc3RydWN0IGRtYV9mZW5jZSAqcHZy
X3F1ZXVlX3J1bl9qb2Ioc3RydWN0IGRybV9zY2hlZF9qb2IgKnNjaGVkX2pvYikNCj4gIAkJCQkJ
CSBqb2ItPmh3cnQsDQo+ICAJCQkJCQkgZnJhZ19qb2ItPmZ3X2NjYl9jbWRfdHlwZSA9PQ0KPiAg
CQkJCQkJIFJPR1VFX0ZXSUZfQ0NCX0NNRF9UWVBFX0ZSQUdfUFIpOw0KPiArDQo+ICsJCXRyYWNl
X3B2cl9qb2Jfc3VibWl0X2Z3KGdlb21fam9iKTsNCj4gKwkJdHJhY2VfcHZyX2pvYl9zdWJtaXRf
ZncoZnJhZ19qb2IpOw0KPiAgCX0gZWxzZSB7DQo+ICAJCXN0cnVjdCBwdnJfcXVldWUgKnF1ZXVl
ID0gY29udGFpbmVyX29mKGpvYi0+YmFzZS5zY2hlZCwNCj4gIAkJCQkJCSAgICAgICBzdHJ1Y3Qg
cHZyX3F1ZXVlLCBzY2hlZHVsZXIpOw0KPiBAQCAtODA5LDYgKzgxMCw4IEBAIHN0YXRpYyBzdHJ1
Y3QgZG1hX2ZlbmNlICpwdnJfcXVldWVfcnVuX2pvYihzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc2No
ZWRfam9iKQ0KPiAgCQlwdnJfY2NjYl9zZW5kX2tjY2Jfa2ljayhwdnJfZGV2LCAmcXVldWUtPmNj
Y2IsDQo+ICAJCQkJCXB2cl9jb250ZXh0X2dldF9md19hZGRyKGpvYi0+Y3R4KSArIHF1ZXVlLT5j
dHhfb2Zmc2V0LA0KPiAgCQkJCQlqb2ItPmh3cnQpOw0KPiArDQo+ICsJCXRyYWNlX3B2cl9qb2Jf
c3VibWl0X2Z3KGpvYik7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIGRtYV9mZW5jZV9nZXQoam9i
LT5kb25lX2ZlbmNlKTsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZTUzMjBiZThhNTg1YTky
ODZmMjMxMzA1ZDBkNDQzZDU5YzI0ZTQ2Yw0KPiBjaGFuZ2UtaWQ6IDIwMjYwNzIyLWI0LXRyYWNl
cG9pbnQtZml4LTBmYzk2MWQ3MDIzZA0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=
