Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15149606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=yIn8bRkt;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=SVgbi7bG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405C310E3EB;
	Fri, 27 Nov 2026 12:05:19 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAFD810E3EB;
 Fri, 27 Nov 2026 12:05:07 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6ARBR2XD3419306; Fri, 27 Nov 2026 12:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=e/jIHXSN5Q/k0C2U9O4+kV1lOYVK77VqLgGSgRBNP1Y=; b=yIn
 8bRktaQnXyoFPO7LBjrAc7UImezTwTqLsJt7R1Rw3rcSJm3uNYodSMwCLJASnj7k
 rlTY04QJLWwEfSBXc7Zqofz73T73Lse8FjWW2lHW3h5IOAUDAHrBxztkWHBHhf9M
 7IQq82I6qQ2cAgyK7NWwe1N+C1Y+0fl7GdOXSYCC0NzzLaGLzc16yKldcpwp6Ypl
 aGBD10XpFSqYgH/TByCcGeRFv7oVp2Mnbo1bxYJ6wJDP3bzeNInUxoCTr6ybzUSn
 M7LsunKu6YgoTbK4mRdNO2VFIHU8GmK9AczzeuK2qn+j12lWffvL/UOnuVg/rzWa
 7tPpta3NwJZic9UPpdg==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022118.outbound.protection.outlook.com [52.101.96.118])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev4gqq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Fri, 27 Nov 2026 12:04:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKzsdWgxUaNORVNh4t0k/0bNiaybf992MarbcYPj2ynfBbhVoqJCX2y0IhF55dhfODrSiSBlRRRZ6kQ89IXRQ7qm53/MWfaY4ZgNISZNseIxnGqJ2GsxLgPrwwD8ZYRGczCJLZjbFWnrk9MiGyDMtWvnrodXkHhxO7WnBQry8ZtorqBcz43SsmV5dVkvdkTTptDzdRCcr+iCTc6QtMvJZ0gTaftbQHXIBnWwiYkDiPDGOWjCPz/Kz69VAexmKmv33isgH6Of/2ZSkkhkM/C8di8Kc5jGhDiQPx8a1vyRjRHJ2IRPJdxMNSMqpgbxxDjN2m3DiVZ0XHTWCzSMec7ExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/jIHXSN5Q/k0C2U9O4+kV1lOYVK77VqLgGSgRBNP1Y=;
 b=YvAuFsYXUr7RF79Yujt87C4SZc1Sa6p4jn+SYfNtLJVehOBnhqNS/VuJP61WmW1PTIfG1Ph0Q83ZdhBgwB1DXXjqWtQXIrcnr0xB6fVZwpEPMiJAmxiFby4/hvfHMyRvRhNzXuNqUWr+Z+TG7dDK0pboIId9BemwPmSxEwoR4ibComrmkzGVwPcdvHSm8UDLtXgqN9cYhT/b6mDqK64f6iB0B9JEnzNLqItyFKTcIE84QwtEMKg4nz5KrOMEP+KnMtD82lfZZqSPhH/B+Inoby+ydOjh+MJInoKtNDY/b4R3+S4KF/zWL4ahUAuTgWiffymdm1d0MqVCnFUo/+WMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/jIHXSN5Q/k0C2U9O4+kV1lOYVK77VqLgGSgRBNP1Y=;
 b=SVgbi7bGE/9CNnQT99rpNxbsVYtO0YFvN3AasqfIaQaE7x+AUY8XMSYjd4UwAZcT4lPh6WfkHgePmVA+LAfrFL9c7iDnePnG3ga9b8Uk9KHAK9gc4sM7wEvTCQEZrJiYG9tKIEFUF+AlIlhtM9RLmmpHGAJ4Eb2p1Vh3/I8gcaY=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWXP265MB2470.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 12:04:40 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 12:04:39 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "pjw@kernel.org" <pjw@kernel.org>,
 "alex@ghiti.fr" <alex@ghiti.fr>, "glaroque@baylibre.com"
 <glaroque@baylibre.com>, "airlied@gmail.com" <airlied@gmail.com>, Alessio
 Belle <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "gye976@gmail.com" <gye976@gmail.com>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: drop redundant zeroing of new GEM
 objects
Thread-Topic: [PATCH v2] drm/imagination: drop redundant zeroing of new GEM
 objects
Thread-Index: AQHdfTaJjzbjQns7N0+3Df05NmkC4bdB1G+A
Date: Fri, 27 Nov 2026 12:04:39 +0000
Message-ID: <cfc8dc44cd03dfd0e65c31bf6c292bbb9d562541.camel@imgtec.com>
References: <20261125-pvr-gem-drop-zeroing-v2-1-8453a6e01e81@baylibre.com>
In-Reply-To: <20261125-pvr-gem-drop-zeroing-v2-1-8453a6e01e81@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWXP265MB2470:EE_
x-ms-office365-filtering-correlation-id: 5fa07579-a09a-4339-fd61-08df4c7e9d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|7416014|921020|38070700021|261022115727099003|10067099003|56012099006|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: l4ZiHTYfh2UC9psZ0S8sfyU5AT8LWgp6c5Zqs/HptUoYZn+KJ6nnB9wnBOtzWrDPTmzaUVpQLBIQIgkpLbjgDBjaICynpmy2qD+zDw4kQWP3WKkCK2+thKdc5W88v4pQ/DEwcAhv96Guj5uKWVORr2Fm+ms87kJpxidS4vGifQ4uXYZ+Kw9eN9K/3QrNcS/qLF1B8iRGsiv615MUntNZmhIv8Jc0Ga+rzlXvaTgi/6a/hvCji5BgsClDqZfvfoe2lY2HcgoLy+bLoj5RhoWTfwN0JHt0NzzAqnLDFwwEY2gMc5FqsBFF9tOtKwBMl+zgHyG6x2jHvcpWx/4jeBxvw/cooUiwycuxpumJ1mGAuJPFCWuHoHI1jjycs4Bgd19VcKgVAOIEVol8ccVl0hyfSlI/0GetBj651bkr+nhDQDxYPksswqbO9hT0PRYrKmzqak0fX5IIESsHNmCVyffUdj/ql3UpmqtC9HtVlYMwSat1ZBgrDroivaPLsOFxMHApOMb7OwWJm+ACIYxhHoZ8Ywi8zehoRppLeQcpWXSubhXUU3OMRIP6hoQC3lanBXbxPULjayrecVECjQDbT8e7pfKAdRIEOE4dEKvnKT2J0OPXbyeSnyEuhmpHizb3kQsTsLBMng8AXWcmIf5ftwmxcrzacXbgOA3j+N/hLda8x3ksAgjWtHI89POwbWu7GeBP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(7416014)(921020)(38070700021)(261022115727099003)(10067099003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGpFNXJhcnd6cnMzWkJZTURMVHFVQ1d0Zm90aTVQYzBlNGV6eEhBL25Qa1NC?=
 =?utf-8?B?VkZFRld5MXN4VVJMQi9lN2phTTN3RzN2d2lCWFhPWTRnNDdPY0tuN1hMV2NZ?=
 =?utf-8?B?YXNwUzdsNEk1WWNyWDVBem80ejBBY3NtKzgvY2JlY09oeFh4enNJSENaZElh?=
 =?utf-8?B?VGhaaFgvUUtVamoxQXVQd015U09MQUJ5TFFRUVY4TlpzdUFvYjJZazNpbWI0?=
 =?utf-8?B?ZzhaQ2pMRU9uZWpPNVlITDZzZVE3REc5cDFrTmpVeTl0WjQ2cFpqMUJNY1VV?=
 =?utf-8?B?TVdKWkFrK05nY09vdlkzVG1JZ21ZRWcvcXcwRTU4NWZvWVcvUGtrcmQ0QW9t?=
 =?utf-8?B?WlQwaThQVitWeFl6djRqYy91Q0plczBjeGNqZDhVUW1TaGJFZnR3MmR1Rkkx?=
 =?utf-8?B?SUQ5WXY3UTRmUS9IWlZmQml0S3l6NXo3MkkyNHhaL1IxUzRwZWJNZW1YbG9C?=
 =?utf-8?B?dExJc2F5eVdxWm9CSnZFSHlXN0F1WXZ2YXkrMDRzSmIzb1dEMWgxYWZsZzRP?=
 =?utf-8?B?enNxSnlVOUpOZTJnTWNrUlVpakxYcmJSekFTUFJmazliSHFEaXBWZzBFdld5?=
 =?utf-8?B?UWhsWmV3RGtTKzVScUtCb3VyU1FpdENHQnVCL0ZKUG9TdjhJM3dhVlR0eUhW?=
 =?utf-8?B?N0QzMzYzK1VlNTEyWDNLMldiV0NDek5jWlRHcCtvY3hJczZ0Y2VHZG5hbmt1?=
 =?utf-8?B?RWxqaVB4RUN0dHMyMDliUEVzRXB1V1liT3BORUF3R0hDVmpDaXBCd1VvNjd1?=
 =?utf-8?B?OHhPWFFJcVNjY2Fmc2N5ZXgwOHlRZ2dSbHdKbkNjakd2R0lxaWVkek8xakU2?=
 =?utf-8?B?NGVqTDFQKy9xdDNRTk5nQldRUFBHYmhKSHZmaGpQWTdxcUE4WklaTkQ3QVpM?=
 =?utf-8?B?SkorMmg4OGJpclJaUzR1RkxMb2JyOTFiS0VacGhFNVFibDl4SC9NNXppMHJO?=
 =?utf-8?B?dTd6YUYwamhOVlowZ2lyZTQ2a2JKVXlwa1N6dEMxTjU5S3N5VFZDU1V5NFpM?=
 =?utf-8?B?MFdkMmxaenVTenU5c1dYQzVEeWdZUzVDL3FSWkdBdG9KQmZPamdqZDlSSmdu?=
 =?utf-8?B?QjRGVEtIRjdJZ3lUc1pxMkMwRG9KMzUyNCtmN2RlSmhHZitPaGtsVHVxVFJF?=
 =?utf-8?B?Sno1WjcrQXd0SGI0eDFsUm1yWXd0REV0RUZsQjJNd1dkaFU4c0RteldkKzVa?=
 =?utf-8?B?TUo5cnNJVVdhYk00N1lPSHlJTW9OVWJ2Wjh6NkVaUHhOZnczYVpVaXF3VmdT?=
 =?utf-8?B?M0JxTmsyZTk4YmVaZ2ZwUzRlZmRLYlE3dTFzU1U2NWF4TGVFZkc5bEMrOVBz?=
 =?utf-8?B?dkI2VElDWnpyT3JBQlF1ZFA2bU9GaGxPRE8rc3F1dEs3S25RZXJ2cCs0NDRC?=
 =?utf-8?B?c0ozcTVsYUlZTnZ5dUNUMEx4Y1d2YW4rVFBpMEMzaU5MdkFqaXpoVTJ3Y2w0?=
 =?utf-8?B?NHEzSnJNY3BQbnNXcksraU52c2VDWi9oV1lZa1NzRW12L3NtbkY3YW9VTGtt?=
 =?utf-8?B?UWxiRitjQ3FvcFROZ1BWR1dqWlpzcFZhaVJGOTkvMVZTNVErbEMwMkFUc2JM?=
 =?utf-8?B?Q28ydTQ2OGVoMlpGTGJlYVVUMjd5Y29YSW44eDdSR05WL3JjN2dLbVM3cWl0?=
 =?utf-8?B?dkpwUEJWS1lYZkpyZjR6b3kvVHJFQmtPaHBKVWpwK2pqY3h0K01zM3lUK2U3?=
 =?utf-8?B?RnRvemE1OEtEZEhNZGJDWjZoYjNyWGRBbCt1aHVlRkJiZ3pLdFJxOVcxa0p5?=
 =?utf-8?B?TFRMSm4zTUtsd2p1TDFIVkpYWW8raHcrM0hCS090SWczbTVTTnhkR3YwYzFq?=
 =?utf-8?B?NFFFOW4ycnZ2blJHSjlhQXRrMVRiQkVDaUdVb2xabWhFa3VtQmhvcTlvMm9C?=
 =?utf-8?B?ZWNTbSt0TzVUcmhzTUswalkyY3VXbVMybXBzdnNBa25EMzVRT1c2ekZTT21x?=
 =?utf-8?B?MzVUcSsya3FGdTcvVEdiTUN0cEVCSGk5Y2laT1JrU0hiK3VVY2U3VHpCaHUx?=
 =?utf-8?B?dTNLc044cjh4YVpFM2s3NnB1aGpVQ2RKUlMxV2RhcEN5L1I5YjNmMVh4RkpI?=
 =?utf-8?B?dE94TmFiUnlsWGt4bERvbmljSVpJN09kbnFUcEhVV081R0VCOElEUFB6THRj?=
 =?utf-8?B?bmtBUmVVU295SDIwS2x6NEpwN2V2RnJlTDBrN3Q4MDJsdFh0TjFvUjFxY1VJ?=
 =?utf-8?B?TlJ3TVA4TGduY3lSVUM5UkN4Tm1ncGRndmZGL0lycEdQNVFoT1R6b1RVLzMx?=
 =?utf-8?B?VzUzSS9uNFI5NnRRc1RRdjFVclNkSUt3YjF2OHRBTEc2OXcxV2hjTHROdzFw?=
 =?utf-8?B?US8zc2JBK1o3aWw5VXZiM2p2a1BVdVpnMGJrM1hTQnJRUGhsb04xR3JVYUNq?=
 =?utf-8?Q?mVo0zUcIUhAf7NiafLbkB1sOR8777H1FEJVzm72EPe06j?=
x-ms-exchange-antispam-messagedata-1: AOKEGEEYlIj1ggBsWokyWHJX78FWqqjEpCU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F9070117C55CC4A9A0F6A1A01939619@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OSUKUKRrcD5KQdqrd9Vp+29DEbSTiMb25MabDZzUN1amPSpvdGCLrAh+pzqgGVu9oGCNBwItKyAp/7wQFo8bJnUwjldVY0Q5H3v+pRjQzWlGk3MG1DeX0l1nM6ap+8PRlTVFeuDYB2/NWM6UhYWJL/WYfUxJd2IcHosn98CmNKKKFX91c4FEWrnBpAV3253NQp3TN2Be+E9eS+5j/aWQnMKof3ClvIG4hP5t5I7NFh1F73ZDOPA1QZ+itm9Y+77oCtjI0lfoI8XGWXVDU/oPbJFZhKmlgUwn6ZN5wR7yiNkdiDGgmzIAtGnHp+ZZC3Y+BnOwcrLiYbzxCO84p35V6A==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa07579-a09a-4339-fd61-08df4c7e9d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:04:39.8319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiHMYaqjuziLR0X/Xj9tAx+ntKIT7VRcXER6hP+glEZNRWcRA9Tm1G/ul+aVLzZODbojLaXWGF0JmpOlfY8oTX+I0m1GUW8q5nrww/Imp6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2470
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfXyn0UBCtWmegv
 ohh/xQSYO/CjXp0wqO6hiHiRtjZEuDLREnGd4gIkz8pASPX2FS5COWC5YFHjbku8kqqVA1BMBPJ
 krjjJqhfObJA5JBN7E1TQLjVKwhfPUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfX+WjdHd04cza+
 ZC6OL+XSLsh08PS8hO8At9hqIb+gh556mxXztjSNBE23wh5fqNJwFMjV8FwN/L2gpg6YlTDok/F
 Y+KzFNki10qQiaBPXx1HzGY1gBNdtcXV7fbVd3vMk1sswO0x4lnXm5Tx8Omii2FAPI+GnJNICOC
 iIr1PxN1aPIi/lMaIpdOCrV83X1xQYDqXim4KpMk0fGb2rgujl5+5FepR5ObCgTJVGgA7kcKo9y
 EnY1/QpTcXkZ9fAfLHdXEbAmO9F4wmHZIsYY2XYLqHus/o7U0e5xwAm/jAkuPC+4IMckiuY0VJ6
 aRm0GwcE65ap3+QcWCTAq9Pmm3mqWrgHn+G3v90wWfNbFYZYpTT4mHTh4fyK+cTK/NAz3B5IchG
 VMN4iU9uBdXOUvHbVAK9Z3PFWk73FfMtTkWb2nhNzsrD+xox77FhotphNZOhNM+RZDE4a+okIUF
 YoFMl+zEq+PmBvOH0lA==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b0971db cx=c_pps
 a=BzI6E2rmsAXjrj6Fd9aogw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=b3CbU_ItAAAA:8 a=bC-a23v3AAAA:8 a=IpJZQVW2AAAA:8 a=r_1tXGB3AAAA:8
 a=pGLkceISAAAA:8 a=8q0DIKUy8RcdCIgXhrwA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22 a=FO4_E8m0qiDe52t0p3_H:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: MYjtoDIh48uQED0lm-teYzdIUU2C0Bp7
X-Proofpoint-ORIG-GUID: MYjtoDIh48uQED0lm-teYzdIUU2C0Bp7
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

T24gV2VkLCAyMDI2LTExLTI1IGF0IDE4OjQxICswMTAwLCBHdWlsbGF1bWUgTGEgUm9xdWUgd3Jv
dGU6DQpIaSBHdWlsbGF1bWUsDQoNCkNoYW5nZXMgbG9vayBnb29kIHRvIG1lIGFzIHdlbGwuIFlv
dSBjYW4gYWxzbyBhZGQgbXkgUkIgdGFnLg0KDQpSZXZpZXdlZC1ieTogQnJhamVzaCBHdXB0YSA8
YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNoDQo+IHB2cl9nZW1f
b2JqZWN0X2NyZWF0ZSgpIGNsZWFycyBldmVyeSBuZXcgb2JqZWN0IHRocm91Z2ggYSBDUFUgbWFw
cGluZw0KPiBzbyB0aGF0IHVzZXJzcGFjZSBuZXZlciBzZWVzIGRhdGEgbGVmdCBieSBhIHByZXZp
b3VzIG93bmVyIG9mIHRoZQ0KPiBwYWdlcyBbMV0uIFRob3NlIHBhZ2VzIGFyZSBhbHJlYWR5IHpl
cm9lZCBieSBzaG1lbS4NCj4gDQo+IEVhY2ggb2JqZWN0IGlzIGJhY2tlZCBieSBhIG5ldyBzaG1l
bSBmaWxlLCBmb3Igd2hpY2gNCj4gX19zaG1lbV9maWxlX3NldHVwKCkgb25seSBzZXRzIHRoZSBz
aXplLCBhbmQgaXRzIHBhZ2VzIGFyZSBhbGxvY2F0ZWQNCj4gdGhyb3VnaDoNCj4gDQo+ICAgZHJt
X2dlbV9zaG1lbV9nZXRfcGFnZXNfc2d0KCkNCj4gICAgIGRybV9nZW1fc2htZW1fZ2V0X3BhZ2Vz
X3NndF9sb2NrZWQoKQ0KPiAgICAgICBkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19sb2NrZWQoKQ0K
PiAgICAgICAgIGRybV9nZW1fZ2V0X3BhZ2VzKCkNCj4gICAgICAgICAgIHNobWVtX3JlYWRfZm9s
aW9fZ2ZwKCkNCj4gICAgICAgICAgICAgc2htZW1fZ2V0X2ZvbGlvX2dmcCguLi4sIFNHUF9DQUNI
RSwgLi4uKQ0KPiANCj4gQSBuZXdseSBhbGxvY2F0ZWQgZm9saW8gaXMgbm90IHVwdG9kYXRlLCBz
byBzaG1lbV9nZXRfZm9saW9fZ2ZwKCkgY2xlYXJzDQo+IGl0IHdpdGggY2xlYXJfaGlnaHBhZ2Uo
KSBiZWZvcmUgbWFya2luZyBpdCB1cHRvZGF0ZTsgb25seSBTR1BfV1JJVEUNCj4gc2tpcHMgdGhp
cywgbGVhdmluZyB0aGUgZm9saW8gdG8gYmUgZmlsbGVkIGJ5IHRoZSB3cml0ZS4gcGFuZnJvc3Qg
YW5kDQo+IHBhbnRob3IgYWxyZWFkeSByZWx5IG9uIHRoaXMgdG9vIGFuZCBuZXZlciBjbGVhciBu
ZXcgb2JqZWN0cy4NCj4gDQo+IFRoZSBkbWFfc3luY19zZ3RhYmxlX2Zvcl9kZXZpY2UoKSBjYWxs
IHRoYXQgZm9sbG93cyBtYWtlcyB0aG9zZSB6ZXJvZXMNCj4gdmlzaWJsZSB0byB0aGUgR1BVLiBU
aGUgc2Vjb25kIHBhc3MsIHdyaXRlLWNvbWJpbmVkIG9uIG5vbi1jb2hlcmVudA0KPiBkZXZpY2Vz
LCBvbmx5IGFkZHMgbGF0ZW5jeS4NCj4gDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2RkMmNlYWNjLWY1OWItOWMzYy1lNGNlLTMwYjNiYmQ2OTM5YkBtYWlsYm94Lm9yZyBbMV0NCj4g
VGVzdGVkLWJ5OiBHeWV5b3VuZyBCYWVrIDxneWU5NzZAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1i
eTogR3lleW91bmcgQmFlayA8Z3llOTc2QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogR3Vp
bGxhdW1lIExhIFJvcXVlIDxnbGFyb3F1ZUBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiBwdnJfZ2Vt
X29iamVjdF9jcmVhdGUoKSBjbGVhcnMgZXZlcnkgbmV3IG9iamVjdCB0aHJvdWdoIGEgQ1BVIG1h
cHBpbmcsDQo+IG9uIHRvcCBvZiB0aGUgemVyb2luZyBzaG1lbSBhbHJlYWR5IGRvZXMuIERyb3Bw
aW5nIHRoYXQgcGFzcyBzcGVlZHMgdXANCj4gb2JqZWN0IGNyZWF0aW9uLCBtb3N0IHZpc2libHkg
d2hlcmUgaXQgZ29lcyB0aHJvdWdoIGEgd3JpdGUtY29tYmluZWQNCj4gbWFwcGluZyBvbiBhIG5v
bi1jb2hlcmVudCBwbGF0Zm9ybS4NCj4gDQo+IFRlc3Rpbmc6IGRybS1taXNjLW5leHQgKDQxZWNm
ODUyYzA3Mykgd2l0aCBhIERlYmlhbiByb290ZnMsIG9uIGEgVEkNCj4gSjcyMlMgRVZNIChCWFMt
NC02NCwgYXJtNjQpIGFuZCBhIFNwYWNlbWlUIEszIFBpY28tSVRYIChCWE0tNC02NCwNCj4gcmlz
Y3Y2NCkuIFRoZSBLMyBhbHNvIG5lZWRzIGxvY2FsIHBhdGNoZXMgdGhhdCBhcmUgbm90IHVwc3Ry
ZWFtIHlldDoNCj4gaXRzIEdQVSBEVCBub2RlLCBhbiBSUE1JIHBvd2VyIGRvbWFpbiBmaXggZm9y
IGl0cyBmaXJtd2FyZSBhbmQgQlZOQw0KPiAzNi41Ni4xMDQuMTgzLiBFYWNoIGJvYXJkIHJhbiB0
d28gc21hbGwgdGVzdCBwcm9ncmFtcywgb25jZSB3aXRob3V0IGFuZA0KPiBvbmNlIHdpdGggdGhl
IHBhdGNoOg0KPiANCj4gLSBUaGUgZmlyc3Qgb25lIG9ubHkgdXNlcyB0aGUgcG93ZXJ2ciBEUk0g
aW9jdGxzLiBJdCBmaWxscyAyNTAgb2JqZWN0cw0KPiAgIHdpdGggYSBwYXR0ZXJuIHRocm91Z2gg
dGhlaXIgQ1BVIG1hcHBpbmcsIGZyZWVzIHRoZW0sIGNyZWF0ZXMgbmV3DQo+ICAgb2JqZWN0cyBv
ZiB0aGUgc2FtZSBzaXplIGFuZCBjaGVja3MgdGhleSByZWFkIGJhY2sgYXMgemVyby4gSXQgYWxz
bw0KPiAgIHRpbWVzIERSTV9JT0NUTF9QVlJfQ1JFQVRFX0JPLiBSZXN1bHQsIHdpdGhvdXQgLT4g
d2l0aCB0aGUgcGF0Y2g6DQo+ICAgICBKNzIyUzogMCAtPiAwIG5vbi16ZXJvIGJ5dGVzLCAxNiBN
aUIgb2JqZWN0IGluIDIwLjYgLT4gMTcuNCBtcw0KPiAgICAgSzM6ICAgIDAgLT4gMCBub24temVy
byBieXRlcywgMTYgTWlCIG9iamVjdCBpbiA0MS42IC0+ICA5LjIgbXMNCj4gDQo+IC0gVGhlIHNl
Y29uZCBvbmUgZG9lcyB0aGUgc2FtZSBjaGVjayB0aHJvdWdoIE1lc2EncyBWdWxrYW4gZHJpdmVy
LA0KPiAgIGFuZCBhbHNvIHJlYWRzIHRoZSBuZXcgbWVtb3J5IGZyb20gdGhlIEdQVTogdGhlIEdQ
VSBjb3BpZXMgaXQgaW50byBhDQo+ICAgYnVmZmVyIHRoYXQgdGhlIENQVSB0aGVuIGNoZWNrcy4g
ODAgYWxsb2NhdGlvbnMsIG9uIHRoZSBKNzIyUyBvbmx5LCBhcw0KPiAgIE1lc2EgaXMgbm90IGJ1
aWx0IG9uIHRoZSBLMyB5ZXQuIFJlc3VsdDogMCBub24temVybyBieXRlcyB3aXRob3V0IGFuZA0K
PiAgIHdpdGggdGhlIHBhdGNoLg0KPiANCj4gVGhlIHRlc3QgcHJvZ3JhbXMgd2VyZSB3cml0dGVu
IGFuZCBydW4gd2l0aCB0aGUgaGVscCBvZiBhbiBMTE0uDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYy
Og0KPiAtIENvbW1pdCBtZXNzYWdlOiBzaG93IHRoZSBjYWxsIGNoYWluIHRocm91Z2ggd2hpY2gg
c2htZW0gemVyb2VzIHRoZQ0KPiAgIHBhZ2VzIGFuZCBleHBsYWluIHdoeSB0aGlzIGNhbiBiZSBy
ZWxpZWQgb24gKEd5ZXlvdW5nIEJhZWspLg0KPiAtIEFkZCBUZXN0ZWQtYnkgYW5kIFJldmlld2Vk
LWJ5IGZyb20gR3lleW91bmcgQmFlay4NCj4gLSBObyBjb2RlIGNoYW5nZS4NCj4gLSBMaW5rIHRv
IHYxOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjExMTEtcHZyLWdlbS1kcm9wLXplcm9p
bmctdjEtMS0yZGM3MjU4NTcwNTNAYmF5bGlicmUuY29tDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl9nZW0uYyB8IDM0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2dlbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9nZW0uYw0KPiBpbmRleCBkODY2MGQ2YThlMDEuLjAxYjhl
MDhkMTJmMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9n
ZW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2dlbS5jDQo+IEBA
IC0yNzUsMzQgKzI3NSw2IEBAIHB2cl9nZW1fb2JqZWN0X3Z1bm1hcChzdHJ1Y3QgcHZyX2dlbV9v
YmplY3QgKnB2cl9vYmopDQo+ICAJZG1hX3Jlc3ZfdW5sb2NrKG9iai0+cmVzdik7DQo+ICB9DQo+
ICANCj4gLS8qKg0KPiAtICogcHZyX2dlbV9vYmplY3RfemVybygpIC0gWmVyb2VzIHRoZSBwaHlz
aWNhbCBtZW1vcnkgYmVoaW5kIGFuIG9iamVjdC4NCj4gLSAqIEBwdnJfb2JqOiBUYXJnZXQgUG93
ZXJWUiBHRU0gb2JqZWN0Lg0KPiAtICoNCj4gLSAqIFJldHVybjoNCj4gLSAqICAqIDAgb24gc3Vj
Y2Vzcywgb3INCj4gLSAqICAqIEFueSBlcnJvciBlbmNvdW50ZXJlZCB3aGlsZSBhdHRlbXB0aW5n
IHRvIG1hcCBAcHZyX29iaiB0byB0aGUgQ1BVIChzZWUNCj4gLSAqICAgIHB2cl9nZW1fb2JqZWN0
X3ZtYXAoKSkuDQo+IC0gKi8NCj4gLXN0YXRpYyBpbnQNCj4gLXB2cl9nZW1fb2JqZWN0X3plcm8o
c3RydWN0IHB2cl9nZW1fb2JqZWN0ICpwdnJfb2JqKQ0KPiAtew0KPiAtCXZvaWQgKmNwdV9wdHI7
DQo+IC0NCj4gLQljcHVfcHRyID0gcHZyX2dlbV9vYmplY3Rfdm1hcChwdnJfb2JqKTsNCj4gLQlp
ZiAoSVNfRVJSKGNwdV9wdHIpKQ0KPiAtCQlyZXR1cm4gUFRSX0VSUihjcHVfcHRyKTsNCj4gLQ0K
PiAtCW1lbXNldChjcHVfcHRyLCAwLCBwdnJfZ2VtX29iamVjdF9zaXplKHB2cl9vYmopKTsNCj4g
LQ0KPiAtCS8qIE1ha2Ugc3VyZSB0aGUgemVyby1pbmcgaXMgZG9uZSBiZWZvcmUgdnVtYXAtaW5n
IHRoZSBvYmplY3QuICovDQo+IC0Jd21iKCk7DQo+IC0NCj4gLQlwdnJfZ2VtX29iamVjdF92dW5t
YXAocHZyX29iaik7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAgLyoqDQo+ICAg
KiBwdnJfZ2VtX2NyZWF0ZV9vYmplY3QoKSAtIEFsbG9jYXRlIGFuZCBwcmUtaW5pdGlhbGl6ZXMg
YSBwdnJfZ2VtX29iamVjdA0KPiAgICogQGRybV9kZXY6IERSTSBkZXZpY2UgY3JlYXRpbmcgdGhp
cyBvYmplY3QuDQo+IEBAIC0zNzgsMTIgKzM1MCw2IEBAIHB2cl9nZW1fb2JqZWN0X2NyZWF0ZShz
dHJ1Y3QgcHZyX2RldmljZSAqcHZyX2Rldiwgc2l6ZV90IHNpemUsIHU2NCBmbGFncykNCj4gIA0K
PiAgCWRtYV9zeW5jX3NndGFibGVfZm9yX2RldmljZShkcm1fZGV2LT5kZXYsIHNndCwgRE1BX0JJ
RElSRUNUSU9OQUwpOw0KPiAgDQo+IC0JLyoNCj4gLQkgKiBEbyB0aGlzIGxhc3QgYmVjYXVzZSBw
dnJfZ2VtX29iamVjdF96ZXJvKCkgcmVxdWlyZXMgYSBmdWxseQ0KPiAtCSAqIGNvbmZpZ3VyZWQg
aW5zdGFuY2Ugb2Ygc3RydWN0IHB2cl9nZW1fb2JqZWN0Lg0KPiAtCSAqLw0KPiAtCXB2cl9nZW1f
b2JqZWN0X3plcm8ocHZyX29iaik7DQo+IC0NCj4gIAlyZXR1cm4gcHZyX29iajsNCj4gIA0KPiAg
ZXJyX3NobWVtX29iamVjdF9mcmVlOg0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA0MWI1NDU4
NTk1YzYwMTQzZDBlYmFhMWUwMzJjOWNkYTVkNzY0ZGZmDQo+IGNoYW5nZS1pZDogMjAyNjExMDUt
cHZyLWdlbS1kcm9wLXplcm9pbmctNjdjYzk4MzgwYTU1DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tICANCj4gR3VpbGxhdW1lIExhIFJvcXVlIDxnbGFyb3F1ZUBiYXlsaWJyZS5jb20+DQo+IA0K
DQo=
