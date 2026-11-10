Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5A606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Q4yucvDw;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=BgsBwVQj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C41410E11D;
	Tue, 10 Nov 2026 17:38:59 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB1310E11D;
 Tue, 10 Nov 2026 17:38:47 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AA7SNFB529064; Tue, 10 Nov 2026 17:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=dqWpOjoda2uGH+2/Imv/4V8x2S6PrCXQsUUKYqYb0Ps=; b=Q4y
 ucvDwKEgg4GvSY+AoO8j/PXMWIagQir1yqELlSpoi6cSls7hpp1D5DM4hYHKDEGx
 XdFW3ZQOCSMM9iFge6I6zn8LlhAvfSfl08jTrsF7Tiibi6GmyWwSZTh9UG+Am1Gl
 BYQxzcDOH8FHGu3NWo7u3+v7uznRXoM3+oGkgcOfLsn6l1P3p7MxxoB8hqAdUYrn
 m6ocl6i/mgFTsdzljlr9NmvI+AIjyKnyDFWqlKYz4hk3UKb1mFB+0U4JbbQtZpFU
 EC/6TQ1t3cPxCNiRr+h5CDhNXODsW7v5vTfg4jtInxY9a2KRMddmL4DfRf5stVGE
 990JrNeMmsLBnv3i7Mw==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021119.outbound.protection.outlook.com [52.101.95.119])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hu8pn955a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Tue, 10 Nov 2026 17:38:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvhBcoBdM9/MwOaTapZMB/t6uEPuAPhlqFEn4jd3xtdrg0HBxyZDOtc6c9nXT6KwsLigpEgvFrKcNgq7rujJJdLJiD6NMmVQfUTADw61lGRshc4iexUeIzJO3g3HG9FuVaDyTTMJ3apGuuKrG6niYAXrB5J+zCmFWq3OS4mlUFZr41hYeGJwaB9kdwcoWkn9O3YUlIJY940vEYgqDR6cgAb2AwAipaS2bQFMIyuZFFpKQv0137wLPIBRPXBwy9wD/UGwmVLJ9ay/bEIdBW3Dg7VLUAdmZKeHyUexl0WKg4iyu+Bjk39qblunckYpna77qVc4N6EyXdDcbjoQ8gwVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqWpOjoda2uGH+2/Imv/4V8x2S6PrCXQsUUKYqYb0Ps=;
 b=jJ9YpbIqkj9SQ7UwWuxwRoDMH7z7mTkvPhqa0VZDJJo4nQ+6yylfWnsLBJoKFxU124qEpHu2H67V/2u5HbtVSIKD4AMaAdOe9Z7eOKWCo9ZgROB8qvwpGp5KRdZSQ/z6o/p9ZpwG7wg1LpVKq5ozgH1LqdUIY7qm6WhlGQZrPARQ6ugiNoty0RpmVxpiBLUSQdBCVxtuFGocWD0qH9GuCHRAc9ogXc3M9PJ0m0i1GCFNqkHtS6o6sQWp1ujybZ8OqPMc6CEqBUqapw0jax6ffSMb98HNzBdrmCnheM8U0AvoxUEQbh/YPSW3Ruu4ILazBstWSQCjseZbFL287Qa9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqWpOjoda2uGH+2/Imv/4V8x2S6PrCXQsUUKYqYb0Ps=;
 b=BgsBwVQjjtnaIp4JvD2biLmIi4IsB2SIYEbeL5B2IDpjWJhFP2S+GgT5nRKSVwD9RTGteNAK1d+TX4JTJU3SWiCziTmWTEzuXgRDbrTcVMsnhALm5gAe7aEu9mYA2BcXfd3xSIBACzMDWm1rbCchFwD3DvLoGDHcTnyD/LZy9Nw=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO2P265MB3466.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:38:36 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 17:38:36 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: "lkp@intel.com" <lkp@intel.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Brajesh Gupta
 <Brajesh.Gupta@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] drm/imagination: use appropriate poll function for
 non-iomem
Thread-Topic: [PATCH] drm/imagination: use appropriate poll function for
 non-iomem
Thread-Index: AQHdbSDPC/M0firCmk6EjUqdQWx1hbcnml2A
Date: Tue, 10 Nov 2026 17:38:35 +0000
Message-ID: <0906f72919a2b9303d38de2dd098013497fabc2d.camel@imgtec.com>
References: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
In-Reply-To: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO2P265MB3466:EE_
x-ms-office365-filtering-correlation-id: a7e25767-1896-41b3-f7dd-08df3f5172c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|56012099006|261028144727099003|261009223027099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261022115727099003|38070700021;
x-microsoft-antispam-message-info: k5QA4Y6XGZr+sB7hW2JosX60d/Ffp/AvD7lfPMTylcPRea+Uyick+Kw5DtKZ7U9qInuxgkY1JOSZJi+nL7dJyKyvJcNT1NIpmpnngegkM/MF7CgfEs7W4BOtYuqHQrbubh/ZepNDpH50Fq2weQRAk/VNsnG4u1MfEA3CTtZqofYJVXtKp2zwBXvAmrm3rxWAdx9/jnCSodLt0aTTml24ILGJFiFjIF6lb6czpqsasPswic9z2DX6BdsSmyGjni8mXCENAQABrwQ8WhoQmxNEs7QntYUJMWmDXC6ZZ1fb75CBfGfcblbK4Nd3glkYme6MILF3LLQzj0+GcxLdHpBwbgjQQ3ePwg4uF1vUGvSUFl85u12pJOCiY2WBc3MpgwirR+RVgQxhgxoZxVzYk3ke+A2fvG6Uv+twIajAK8eFAhl6zDNuZYMp9RO5qLBk9VAK3Xae9bOBhCIufAR9jYLaS73tXxs0Nl4uyAfpdXmJA+fvRikUc0bGpTu06rxRrknuC//bSGrP1gMH0AVoMXk+7VAnct2mEDReus9q9qeLCx7ykKthyPDRTu96hZLz1PunswSEMGQE3vLPMEP0PdlTdY7/DYXJrBORzvPL1JCqhtCPIGQdl4tgOJF4sNUeCdkYWJA+pzXTUnvIqfuzjtNEeWp/hWb2XPZhrI2PKa/vRtk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022115727099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHR0SCtub3RQcDY3ZEloM0ZOUlpiOHhIbGFnd1kzTjBMS0pXRGRjNHJNazZE?=
 =?utf-8?B?RTlkYmQwMDRRNnp2alFRRFozOVQ1Y3ltdzZuZFhOdW4xNzhuMTRIcmk2M0gw?=
 =?utf-8?B?VW11TXFTeklmQ3hCaUk5RUNqU2ZNVTRDRnZrcnhuSUtwMzlGVE04WXV6Ris5?=
 =?utf-8?B?UFFSNG1XY3phdlNzS3BVZEFtRjVudnoyYS9QNmVTS2JaNEdPcTVTQzc4ZU9t?=
 =?utf-8?B?ZVc4OTA3VW5nb0lVcnNFdWM3RnFKRlJleXZ6TmlGZ1gxNU1nZWsvY2RhOGQ5?=
 =?utf-8?B?NTF3WDR2L3g1UmZMbTV2SGVzOG5jbGhtVk9TSHVWbVdjNk1DSDQvNnEzSDBO?=
 =?utf-8?B?NXBLeVlxVDJlcmpmU2g0TVV0ZmJwSmMyOVNMaDhTNmFodktkeVFRVEdSa09J?=
 =?utf-8?B?bU90Mm9nKytqNDRSTjlyOSs4N0JKaEZ5dEZZMXlUVzlJZUVkYzRuRkdMWXhW?=
 =?utf-8?B?ajRWTGpuYnlxdkxoaDh2dlRmdGxabWZhWjdYbUw2YnhIN3p5SGFyREROZ1hB?=
 =?utf-8?B?Y2xncXBiU1U3TEdNMjBCU0RjMzVJVjNmN214VzVFcWhLUTZQQ0lwaGJjMS9i?=
 =?utf-8?B?RlBMWXVXQ1hTOHlYQTR2dENHZmVjU3oreXJtU2cvR25oYjRlL1lZVjFPODhj?=
 =?utf-8?B?M3l5ajlsS3lDUnRGYmJVb0ZCSS83aklpVktOVENJYzl1K0p1Vk85VHNsd1lG?=
 =?utf-8?B?cEdlejZhbE1nbWJDbDRncW8zYytwdjhLN2U1Z3c5aGVsQ1NnOHNiR2d3bEdi?=
 =?utf-8?B?WGJSck1JRSt0ZXAyWjAreGlxN1MvM1NiNkZuTVRwKzFnR0sxQWNJY3Myd2ZH?=
 =?utf-8?B?SE1acit0MzM5TFFvSmJ1WFBUaWI0bUNsZlNXQ0lMZ3B4OHFTV3ZMSUJHUmNi?=
 =?utf-8?B?dzA5bCtzR0czR0VhdEFsKzk4ZGdoN29jSmhUeUVxUDZIVlBmUjc3WlpNcGtk?=
 =?utf-8?B?WkNXRUN1VmE0QmVOWHFtazl6dlRWV3lLS0EyblNodmZBYkJqYkIxandJdGZk?=
 =?utf-8?B?S2Vzck1xMUw2bWdnSGZ2ZDgvd3ozS3ZKUGZEU3ZtaHJvelBvUGhGV0RFancy?=
 =?utf-8?B?dVNLMk1pUGZtRStzbGVXK2ltWTJiUTFWRFFwZFd5aEdmcXkrL2ZLK1hnTkpm?=
 =?utf-8?B?VklueU4wNXc0V1J6YXRPNTZqNG5hQU9mcUMrMGJJZzZkZDdBUFl1YWhzTlYr?=
 =?utf-8?B?aTVHY3lMNzVsWGxlVWZaN00yZ2I4NFoyVDlSL0c0Qkt5dW9IcmFMaWdaZjR5?=
 =?utf-8?B?eEhWWkNRaFZUSFlxQ1ZZaHExZ3dyd1BDaVUxMko3djRkM2J4L3haQWFzRXhk?=
 =?utf-8?B?STJ5MGFaV1UyS3M5SGd1YlNCTlFsNmI1dmpoeHNoY1hseURPWUg3L3JyZDJY?=
 =?utf-8?B?VUxCVHZnNUdLYzNWUEFrampMTFMwVk9JMzZqYnBHNTZWM09meSt1UjcyYW14?=
 =?utf-8?B?WXhGTVBPRllnM21iTEhBaUpuMXhwSENNV2dNUjM5VkswZE5wS3dGQ0FCNEZT?=
 =?utf-8?B?ajcxWW1CSXB3L2xnQkdKMDNrL0dhdWVsY0ROWWk0NVJzMTkrN044N2lsQmxo?=
 =?utf-8?B?b2xBZmEvdFFEcDAzTHJ1Q2pGbHpQU1hObEVlamlPYkdoVjYvRVJyUWZIS3cz?=
 =?utf-8?B?cjdhUUdYc2FrRkQ5UUpSMUZhSVlmN1g0QXZLbE8wQ3VPMTJ3UTRMai9HYVU1?=
 =?utf-8?B?QUlINThzckF0bXBvQWd1UjBnN3dLL09GcHVpckw0aDY4SnFFOXhVQUE0b0No?=
 =?utf-8?B?QnN4bHp4ZG1EMHJVbDdRaGpxT0gwaWxWaEp4Q05xWWdlbnhTbEVaU1ZMUTdx?=
 =?utf-8?B?Ym5oVXhFeFY4alJTUTJvY2tDQ1VxaEFCQWxJaVhQa25MSndkSTlwMDhKUVNw?=
 =?utf-8?B?eldGblNYRjlibmhCWXg1Uzh6dE9XMU0wSmlLRC8zdHNKTVMxaEdJWXVoWE53?=
 =?utf-8?B?enk0c1BUWWRERlMyeW1iREl1Wjk2akRSS1lvR0ZiR0o4Ym4waUhPNTYyckZu?=
 =?utf-8?B?eUd3VXo1NjVoTW9RZWNrY0dZTnlXRGpzSlc0eGg4MkhaRzRCZWg0Qmg0eW9l?=
 =?utf-8?B?WWFYU2hkWkZickpvNVhkcnhnRmN1NUcxdjJzb0hEdGJoRGRERFBOdDcyTE1l?=
 =?utf-8?B?bmFLRG8zYy85MzJyZ2gzdnBpNWo5ZDdpMllJc2tmVlJCUUhzbUlwL1hNQjJa?=
 =?utf-8?B?Q2ovU21vQ29YcCtoVUtHV1N1UGxmSDRQeEdZVlQreHhBdnF4Nlh2SDVEaDV1?=
 =?utf-8?B?cUo0MlhScGlSRTZBZjBhdGRxdlpQWGZWZEU1WmFUSEVCN0NPK2Q2WHd3eVRK?=
 =?utf-8?B?N3F5cGRiOXBpak94T0N5S3QrMGoyU0Vqei90U2xXRVVYSytNSFhXQlA0MlVx?=
 =?utf-8?Q?JZPmyGe1nzTIAX4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2118EEBF0C95C84AA18D49119D7A6885@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kc8p4hjA5vaaIvsjgjhIwtRShijjL8V1EuAv9LFf1WKifxCwgbGnkaqwYGfohr4zxMpH9FwZJ1nMK0S5EAhLRNyceO3Y4ezgaeG5eEQVEtOXw7vwGePCHZLONcbbPkDl5EL7dUYLqNqJxLX1GgjQ8yl+QuSIjINxvY0njUq87S6eCg/mqqPh9PqCG3mguvx34kc/AI3IqDFDYBsPazw+huRDYyJoNIaEfmoNta7V6e+Jjxprgs9jRiNs8+qGJJXfyso1fxCLm6Jt9PLGEe8HXeMX+2NRdS8MMA2QJbh9rIw4zEJ6nMk1Z79RQAJgy3WaK3vKGHxnVmghALiLaSL+7w==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e25767-1896-41b3-f7dd-08df3f5172c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 17:38:35.9741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvHaXZI7m5afpmkxSiJMf2TREWcHipc6BX0l89Szmfs7u5/xbDDd+fHfXjubnVUeQrj/gYreV+HbEuVxHvRo7aQMFcTvXXmO5UzQ6p1e2vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3466
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6af3569d cx=c_pps
 a=umo8TZUd7E50GOAIdb9AxA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=r_1tXGB3AAAA:8 a=craggXHLatwVVKPEDpEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX0TwH6nDgXgsl
 2U8r5d/crIx5en5yd8ntN0R4kd3cJRlTBptuUkOhpZ8eUVEmaa+DLvyPhgwU4enBQt8bnXu7kS+
 Dt1A59icXQLfvbnkU8VDbZ4jXAx7QWPPSjymJdDiS8XgnI79EPcxOejo+3h7+FZAHOIQM5lXNCZ
 lJp+9SRaL0vbEkE8DlhwqOUfYrYtqzKWTjH2aaLHKzg/evGXtb2TSzDphpjlRO0yx4t71hUpyhh
 Q4ouTJf64QsWZFu2hdG7ZEtq1GT8c+0dete2+StTeUuJQZBBApqstjWCTWpw5G1QsIw9A6uOs95
 tmlgi5RZSp0sARZekop4YBO32Dmi9QqCHObdx+tiYlP3YzvGrAl6sH2vC+fQPdkahAbuTVD63uH
 e1Op6FipdnrWNrZ466oFfoijXMXXg0W9XDvrGnBBCBtuZWR8wWX/VuMLXd9pAputpj+JAQUPfR+
 X0ujsBMRVTTmAu6kZDA==
X-Proofpoint-ORIG-GUID: FZTn09A9AMZvMy-BuQq4vaZL4RnKvJZc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX3q7+T6N/lQV5
 +vSbOjlwZaKLpRkqHRGMQc+YYlBIzFB6HWsWCR7SMTT1OwvQxAa0NOndhnMC7fa1vNccygNB6Cc
 wpi3mbLVtlep2IuZaFzI63CebW53hpw=
X-Proofpoint-GUID: FZTn09A9AMZvMy-BuQq4vaZL4RnKvJZc
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

T24gVGh1LCAyMDI2LTExLTA1IGF0IDEyOjI1ICswMDAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBwdnJfcG93ZXJfc2VuZF9jb21tYW5kKCkgY2hlY2tzIHRoZSBjb250ZW50cyBvZiBzb21l
IG1lbW9yeSBvbiB0aGUgQ1BVDQo+IHRoYXQncyB3cml0dGVuIHRvIGJ5IHRoZSBmaXJtd2FyZS4g
cmVhZGxfcG9sbF90aW1lb3V0KCkgZXhwZWN0cyB0aGUgYWRkcmVzcw0KPiB0byByZWFkIGZyb20g
dG8gYmUgcXVhbGlmaWVkIHdpdGggX19pb21lbSwgdGhhdCBpcyBnZW5lcmFsbHkgdXNlZCBmb3IN
Cj4gcmVnaXN0ZXJzIG9yIG1lbW9yeSB0aGF0IGlzIGFjY2Vzc2VkIHRocm91Z2ggYSBidXMgYW5k
IG90aGVyIHRoYW4gcmVndWxhcg0KPiBzeXN0ZW0gbWVtb3J5Lg0KPiANCj4gRm9yIFBvd2VyVlIg
aW4gcGFydGljdWxhciwgX19pb21lbSBpcyBub3QgYWNjdXJhdGUgYXMgdGhlIG1lbW9yeSBwb2lu
dGVkIHRvDQo+IGJ5IGNhbiBzdHJpY3RseSBiZSBzeXN0ZW0gbWVtb3J5IG9ubHkuDQo+IA0KPiBG
aXggdGhpcyBieSBsaWZ0aW5nIG9uZSBsZXZlbCBvZiBhYnN0cmFjdGlvbiBpbiB0aGUgbWFjcm8g
ZXhwYW5zaW9uIGNoYWluDQo+IGFuZCBleHBsaWNpdGx5IHByb3ZpZGUgd2hhdCByb3V0aW5lIHNo
b3VsZCBiZSB1c2VkIGZvciByZWFkaW5nLg0KPiANCj4gRml4ZXM6IGNjMWFlZWRiOThhZCAoImRy
bS9pbWFnaW5hdGlvbjogSW1wbGVtZW50IGZpcm13YXJlIGluZnJhc3RydWN0dXJlIGFuZCBNRVRB
IEZXIHN1cHBvcnQiKQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRl
bC5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8y
MDI2MTAzMDIxMzYuM25saTJpangtbGtwQGludGVsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogTHVp
Z2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0ZWMuY29tPg0KDQpSZXZpZXdlZC1i
eTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpB
bGVzc2lvDQoNCj4gLS0tDQo+IFVzZSBhIGRpZmZlcmVudCByb3V0aW5lIHdoZW4gcG9sbGluZyBm
b3IgcmVhZGluZyBmcm9tIHN5c3RlbSBtZW1vcnksIGluDQo+IHBhcnRpY3VsYXIgb25lIHRoYXQg
ZG9lc24ndCBleHBlY3QgaXQgdG8gYmUgcXVhbGlmaWVkIHdpdGggX19pb21lbSBhbmQNCj4gYXQg
dGhlIHNhbWUgdGltZSB0cnkgbm90IHRvIGNoYW5nZSB0aGUgdGltaW5nLg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcG93ZXIuYyB8IDMgKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jIGIvZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jDQo+IGluZGV4IGViNGI2ZWNkZjRmNC4uYzdjMTYw
OTEzZDdjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bv
d2VyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jDQo+
IEBAIC01OSw3ICs1OSw4IEBAIHB2cl9wb3dlcl9zZW5kX2NvbW1hbmQoc3RydWN0IHB2cl9kZXZp
Y2UgKnB2cl9kZXYsIHN0cnVjdCByb2d1ZV9md2lmX2tjY2JfY21kICpwDQo+ICAJCXJldHVybiBl
cnI7DQo+ICANCj4gIAkvKiBXYWl0IGZvciBGVyB0byBhY2tub3dsZWRnZS4gKi8NCj4gLQlyZXR1
cm4gcmVhZGxfcG9sbF90aW1lb3V0KHB2cl9kZXYtPmZ3X2Rldi5wb3dlcl9zeW5jLCB2YWx1ZSwg
dmFsdWUgIT0gMCwgMTAwLA0KPiArCXJldHVybiByZWFkeF9wb2xsX3RpbWVvdXQoUkVBRF9PTkNF
LA0KPiArCQkJCSAgKnB2cl9kZXYtPmZ3X2Rldi5wb3dlcl9zeW5jLCB2YWx1ZSwgdmFsdWUgIT0g
MCwgMTAwLA0KPiAgCQkJCSAgUE9XRVJfU1lOQ19USU1FT1VUX1VTKTsNCj4gIH0NCj4gIA0KPiAN
Cj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjMzQ3ZmVmNWY4Zjg5Mjc5ODViZDY3ODM1MzMxY2U0Y2Y3
ZmY0M2E0DQo+IGNoYW5nZS1pZDogMjAyNjExMDQtZml4LXNwYXJzZS1pb21lbS13YXJuaW5nLTIx
MTFjMWU2ZGJlZA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLSAgDQo+IEx1aWdpIFNhbnRpdmV0
dGkgPGx1aWdpLnNhbnRpdmV0dGlAaW1ndGVjLmNvbT4NCj4gDQoNCg==
