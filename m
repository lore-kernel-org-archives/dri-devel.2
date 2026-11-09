Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD69606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=XHQsJjgq;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=qJH93IjX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA7510E82D;
	Mon,  9 Nov 2026 07:59:48 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA11110E82D;
 Mon,  9 Nov 2026 07:59:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A974jTw2011149; Mon, 9 Nov 2026 07:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=Tk/D0nCz20RSSpIGQZFB+0Veuo6NgcTzPFc6VTQUsic=; b=XHQ
 sJjgqyBPYLJGKuEo4Rr9uPmZS1gTbEVmNwNw2FPQaMEL66ZzzlXzKLyKnwhiacpb
 FaDCJUgQRarLzFLuzV4LfdagqlQ+7ZMzCEufT0ccNXywcHhi9GqmlOOj5ZId3+TF
 PCTzpqnQHmIplIyieeoBf7sexuXFh1dFcse2S/kkhYFgn05eYlcrwss7SxR2e+J1
 2EX0+pcOMTZMXkTZK1TiNPHUQ9m/BhnzPsAl7hG03F1Ks/yoSt0nYrnc24eF+Xg2
 J+Z4iV4hIi0k/sdrHK/6+IDu/nkPBUvWrwVZMngNgIjjYhTcCjiF/VxSR2zac1ZL
 p57VIrYRn41Mvox/B/Q==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx1b37-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Mon, 09 Nov 2026 07:59:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdUz5GFWLxUUCtdtgFwlZP9+wysS48VJR8dtIPwSO27L/+8+LLCyYg9PgWmpmqoyo472srWp8IbJ9j9Fip6gp7lIQb3MxxTsbh1no5j0dW7cRazpTqSixHwDLTtUMxFsY0Av1G2yXy1YNntxddNNlvFoCFIWVfyKtb55ploONt90NXqTu2AhKLvsc2h8hUNY3xDr50zEHCfzxnv64hqLkhYr+zwgECnLUY7F3g3L0/oy9TWMmWGjiCioeQOxHgBAoVDLLDv//bYKwA2DuMCQr6yjlOQmWa18FA/QqSCbGKns46ucU6bRrMyMFpWrZqkn2KUpWoCfXJzQaItswYejmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk/D0nCz20RSSpIGQZFB+0Veuo6NgcTzPFc6VTQUsic=;
 b=vKbqKWiNoYkZZbdN6AH0RMyTWazN5XKhczqAEMIPqiyaZeiAyzWVXaKoaq8FGcR1fRyM9urQXafplQwmCFXEaVGTy+ALWHFdzKGEMDmaBzAndEbkkYlAVIBtfKGiiEG3VdLD6ozyv69Hw/FBUgcmNHgkaySmTiqF2No2Kxuv9RJk1BVH5/n3rSB4TdCEzPqEEC3o0ff0dMaZS4vKu//LclJ6LrZ+cDC+hY13fy4DkcTYokzPBJ/1ueW4M3OCkB9Go2guuV9R8cxvPYQ9P1G/lkw7/X81/no266fVqZCKphY7NGvJ4YABnqeNC/Z3ovLcrKbrfDjX/JdohA2OzB2mhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk/D0nCz20RSSpIGQZFB+0Veuo6NgcTzPFc6VTQUsic=;
 b=qJH93IjXidMYAaU+OR1MMzsMFe/jz/Ki0kixTkctTX01xByhwxaklcPIJOvE6KhasiTpazu4u2XpKEOlZhrG0DyWx3ueLKaghPyCIT3ZG8jQiXe36yabAfvI79topRoPkzuy+x4smwLnVG07+GQr8fnrtr4L7HnJApSf4J3bHR4=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB5360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:59:25 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 07:59:25 +0000
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
 "opensource@mtcoster.net" <opensource@mtcoster.net>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] drm/imagination: Clean up MIPS firmware interfaces
Thread-Topic: [PATCH v5 0/4] drm/imagination: Clean up MIPS firmware interfaces
Thread-Index: AQHdcCA91UHYONLVm0iChgDsl9aCjQ==
Date: Mon, 9 Nov 2026 07:59:25 +0000
Message-ID: <06a1e803ccaa211042d5acc2a9dcee96d60af8fe.camel@imgtec.com>
References: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
In-Reply-To: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB5360:EE_
x-ms-office365-filtering-correlation-id: 4fe23408-f894-4f0e-970c-08df3e375f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|921020|38070700021|10067099003|56012099006|261021123027099003|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003;
x-microsoft-antispam-message-info: KxzoQWZTQVnjxGGZjZHjbXB9vGw0niBPdl1gs4vthx95r7OIM3mp3Yy0AesRbVbpXiihzyHfNJsXSVqx/vrQoZWKMR+N/IE2nUT1kkDVQdVVdwJjQS3YzOoZkVMU62wPudDRcFqwU+a16HR7fhYqwXNl39C3IOMhViRf2HLjxc2rfoi9D3h4ftG4FnDyzGyF3p74vEF1egCbPHp/4Isi82NS/2N5koE6Ga5wR1VqbrUkHO7A6aCK+4UhwunGJRQPnxm08qCIqwR46oJ0dpPz7jUgmBD7HRfUH2W/Z9bkna/HVNAXJPQwybREnMyL2NYcjWc4G1Q0spQomnVnA485v6kNZ60zWelRg/hQjF1bTbVkhPm5CogHFJOsnIWa8IKwrQqJ5i3zKZZTkT+HdipEwqouA5ItF7IcfInlXoUa9YwUbkeQIJ1kyRkZgmy11XYW9x7cBcBnHQ3gUNgT+5Ew22t4lSV9oKDeUnCtBvGs7I1TvWPjN2JKqzRuP/JIFS8v9Z/67Z17ramdiZ96F8CuXB+GLl9mI6910DE1eIGaoMpbnCE9oXEfyxgwhzMpDeKuyEoalnDbOQz+xzTabtUykoUO9aYBBWFIMxaF1747XP43s0r+SwRjgZzDwZjVBX1cpFmmxO5nZjFXTOVKRfv70QfuntDCuo6drqv8NAdjOvwzSXECb+gddg6gKHNHWKKs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(921020)(38070700021)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U280dGl5cEtmR002MUdOU0xQSFpleEJBYTVST3NYU0NuL1ZYdks0L0lFWkl2?=
 =?utf-8?B?M1Z4Ui9GMUw4NG5udzdRY1JyZWd4c3VmY1IwY0VNY0F5MnVkVmpTcXJDQTIw?=
 =?utf-8?B?R0p1Vm82SHBKR0tSb2U2aGNWQzNVLzd6WHdVRFRqMno1OHZRVTVkUTI0MXF6?=
 =?utf-8?B?YzU5VnNhVFNjbytvaFVYQmdEaWQybVIwWGI5ZUZyOVQvYXNCV1pXSUtNOGRF?=
 =?utf-8?B?UldoMVFhempPakkzTDR4SzdzSzltdEcvZlhPYnZDeFlEN1F0NGdXRE5rcnB5?=
 =?utf-8?B?YWJvL2Y0Y2NxSUVsQU04VVJnTzhPRy9jRjIrWFFNNEpJNWpWVnVmM0oyMVRX?=
 =?utf-8?B?ZkNueGlhL1F4bWlOZWVuRXRWdXFzS0JCZS8zSzdVeldmTnVPSHRNdkVIRWNl?=
 =?utf-8?B?ZTkvZENHV3NsT2h1N1JlMGgzMjJTSkpUL2hEZWtNMTlMSGxUbHBzaTFmNXkr?=
 =?utf-8?B?TnNiNkVTMlNsaU1SWnk2OWJzRWhzYjZJbGs1R1VsNWZzMllUZEpLeVdxSFZZ?=
 =?utf-8?B?bm9DV2VmK2hwUmoyYTE2b21GZUpvN2ZwZFZEU2tzMVZnZTlkV005ZVNza3h6?=
 =?utf-8?B?Sy9OdkU5UW8wS2M3LzJVakUrOGloWUhuRENIdmtDaE4ydVloNjMxWU9JbER5?=
 =?utf-8?B?cDYrYTFpWk9lN2krdzNHK1VFVHlqTVBXSlU1ZFhqcmhFenk2eE03MDN4ZVBO?=
 =?utf-8?B?NlA0cVU5OWVmY1dXZnRkZVVVcEFvdHo5Rk9aZXlLcEk0NkVua3JLWm84Ykpv?=
 =?utf-8?B?SFcraXBvM3ZrOHZvVXJOdUJOWHFxUTVwWE5mTnA0c3doRlA1VEIwcEE5dWJk?=
 =?utf-8?B?MGFuRDN4eXdtTHlkbkxxaGl5NnRETDRJRHpiVnZDWmZnV1lhYnpLTXZKaS96?=
 =?utf-8?B?VVV1LzNKb296b0xRbHhOVGtGT0o5SE5pVlVCUU04aFZRemh3NlppZ0Q5Sk9Y?=
 =?utf-8?B?VHVCM2phRTRxbnpDUGE0R09uZXMycGp5ZzRSWEhIcnJhRXZYL3phME9oYWxv?=
 =?utf-8?B?NENrUUNpbTc3YmhxMmQ0V3o4UkVKZXR6dU5mdzZobW5VUFAraHljYTE3M3ZB?=
 =?utf-8?B?VVlZMlkvVklwQ0Q2NFVKVlpYekN2TE9IRjllbk9hUXBJbUd5WWM0RmJSckF6?=
 =?utf-8?B?U3BQQ1JBbUE1UndqdUg1Z05XdDIxamh3dmUxRGpnUk9keFd0OUphbWhFODN6?=
 =?utf-8?B?S0FJTGNBcUpZaUtWYmJqYjYrME1QM1JNblErcWU1akVkbnhLSjF4MnNsRWdV?=
 =?utf-8?B?SnNqRE5uQSt5OHR3NHF4dmVFU2ZFREExUTJVM3pGT3VWWlROekFmRjV6OTlp?=
 =?utf-8?B?N1RtejBkNGQ3aDdzbDVLVFRoK2pnMm51YWpMVlpOSFFnSE4vSEZkUXhnN24z?=
 =?utf-8?B?U1UxS1Y2RjhsdWtGcjM4a1kwUFBaUzRpVnpQUitqYlB1K1lTbGlYM29KMDBU?=
 =?utf-8?B?cStjcTlRcWl5TE85eWNjUjhvRHdYZ0d2eStXUS9ZdVFMamp6LzdTZHUyc0Fl?=
 =?utf-8?B?N2hJdkJSa3d2TWtKNFFPUXJ3dFREVmhWR2dBVXoxaUREa2dvOXEwejV0MjM5?=
 =?utf-8?B?YjJsTmpibkdJYlZjMURmS2dmNWhtVG0vVGh1TkxLR1FZL2s1MW1nS0xVbUhP?=
 =?utf-8?B?Wk1SWENraWJRcTVwWDArOVpGbTJBWlJYdWdpVGdkakh3VjJxcjdkTFpGWk85?=
 =?utf-8?B?R0pTbFhZY1ZaclIrOFp6MnpLN2FyRDdUakQxKzBJTEN1VnJ6UEs4bXUwR0I5?=
 =?utf-8?B?U2kwa2F5ejFVb05BS0NsWC80d1VpeDBiMWw0U3AxaGJTcGpsODh0KzJzM0tq?=
 =?utf-8?B?dEd6RGhIQVBlM245K2NlMzRHdFF3VzdaOG4xSVo0S25GZ2tneEh5WENid3g1?=
 =?utf-8?B?aW53MzhUVmlWbjFhNEFCd2w3bnVpaFV3eHE4SlFQNWR1Yy9yN2o0Sm1ObWNF?=
 =?utf-8?B?ZGdpTGtyOGM4TUM2ZVhtNVY4SHhldDRKZm5IY2x1bzBJaVB3azJNeC9malRG?=
 =?utf-8?B?TE9HTGZLMDZaV0d4ZGR5NzQ5WHZlcm4vdDBFOCtLS0puZit5M1pvdThyeFRL?=
 =?utf-8?B?ckpXblkzLysxN3BIK2xtUnBqVmZGRlpkMEplOHlsa21SNm4xRHNnOWZVNFVa?=
 =?utf-8?B?Zk1WVWZmUnFIZ2FZTzhDNVBSRHV5NDhKeHQ4UjJCUXBOVTgyVnZCUzZqM2c3?=
 =?utf-8?B?K3l1T3pMdko0SnJCUExZbE5ycU1tWEJlTVJmWFRHK2xkUllndGVSNXRrbGVT?=
 =?utf-8?B?VmZwN0VLNktWWXZ5QU1VZXZJV0VkdHRUVThwMEFTMDRuaDBaWllzQjR4SExD?=
 =?utf-8?B?NFlDRG12ZmN5OW1MVVZUUnRPRXV6RXdWZ2dMQ0padTNCcnVMcEQ0RGdWNFI2?=
 =?utf-8?Q?ZZHhq0aUB/BVb/6jAgKLEhC1YbIVdcLbKyk14nwcd9NK1?=
x-ms-exchange-antispam-messagedata-1: kT6KZeHiG3ScOE8HC1UCZgax/3qtqOdWzts=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC25D85BEE3F284A9C9536FB2FF0FB47@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nkpc1gd6wXSw6PQv29VOuLv2qeUqR3fgBi8L9i23cJzIElycw3Q40zzrpiuG6A1VNeB4IMlRd0eCN5GWeBWa54JGwuJcEdygVn4HzdnO2iEv7T0/EkNxw3Gob8uGbDtB24SZvap82UIACvUHrWAYSv3njSuHds42YG4tpDdsjdzp0RWRkUkFxt7vzYYG9Q0u7GXCklEq0U4nfXUiat10pj7Ot1WESZ0IGZndiQ/X3PNU0adpMA0VhM1KdD2VMDOX4GLTiI5cBo0PwC6WEwsBBAaSSIYH3oXs+6+6XnLOGYYS/09m6ZtVLSnlypjbXIcc0L1/HECeJ0Msa5hROVNZDA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe23408-f894-4f0e-970c-08df3e375f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 07:59:25.7072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJnlmqWysy1ekh+zp6IcmJWjstKm8wCVUsG4EtH4btT2GalLG7nDdl80XkhfrWyDCwfS1WiaBz1s8syp+9qz2h5lx7DP3MnjuAzTIEvB6oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5360
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzMSBTYWx0ZWRfX2+2JDteYcYAr
 /r8tFTegnTAPSfsQthC8mpyOh5U/TeZRoU1dIYso2YMD3oIi0n5KtPqP7ceu8ixSGREKKX8Ir3x
 E9YdbizOH2NTLEq2xSlhZZ+45JSxe4E=
X-Proofpoint-ORIG-GUID: 0SaWD2QKWfF5yabQopb_HNV3PkBy72t-
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af17d5f cx=c_pps
 a=7osknE5velPxwKFzkRRHsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=XWCimdJHYoRkDFDAc14A:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=2TKV-7w1aU1AVAwN0oqT:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzMSBTYWx0ZWRfX5AbXORegvC59
 pnEF6XIm9LUrokXUqLJfTWsfolP9Zv/97cw/HpuZ2pehBZHuJu2Qv58ofFXI83ocCAZaB+hMx2u
 Inp9pFbGAcw54ilvN2kvZKeqV87EsUUoRGBFY3XiOMbmdQcZ8bGlpQ5l7zZCBSCGMyoMoCeEmkF
 3+/KXqdz6SNmudi4NB9w5bmGjyHia9OfZerT/uptrV2lm47sARJG40e7SzY8hzXcfeWRTbZQMPy
 xvgcqs+1Q22/1D3dzeB5IeadRdS4nizYzfMiIrOfujTeX0LHQERgCm9+o4aeq3PJ3rYfZBrd9Mj
 aZ9Nlaawts7tN4F+rnAn+FIevptPF0ISAKB3TR7ZJiFDTPLW3tnUHYvbjL87okZ/o3elOsnnOYR
 KLOW2T9UQSvdknlz++AvpdgZCgk1utLAmEJDHDWXEDvjPCl/lkGifuMzyfJXEfR9DA6AzhuwRL4
 9a4a6PBUmnIWMI5NMSA==
X-Proofpoint-GUID: 0SaWD2QKWfF5yabQopb_HNV3PkBy72t-
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTAyIGF0IDA5OjA4ICswMjAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IDEuIExpbWl0cyBhY2Nlc3MgdG8gdGhlIE1JUFMgZmlybXdhcmUgaW50ZXJm
YWNlLCBrZWVwaW5nIGl0cyBzdGF0ZQ0KPiAgICB3aXRoaW4gdGhlIHJlbGV2YW50IGltcGxlbWVu
dGF0aW9uLg0KPiAyLiBBbGlnbiBNSVBTIGZpcm13YXJlIGhlYWRlcnMgd2l0aCB0aGUgb3RoZXIg
cHJvY2Vzc29yIGhlYWRlcnMgYW5kIGFkZA0KPiAgICAiX2Z3XyIgY29tcG9uZW50IHRvIHRoZSBo
ZWFkZXJzIGZpbGVuYW1lLg0KPiAzLiBJbXByb3ZlZCBsb2dnaW5nIGluIGVycm9yIHBhdGhzLg0K
PiA0LiBTaW1wbGlmeSBNSVBTIFBURSBkZWZpbml0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPg0KPiAtLS0NCkZvciB0
aGUgd2hvbGUgc2VyaWVzLA0KUmV2aWV3ZWQtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3Vw
dGFAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQnJhamVzaA0KPiBDaGFuZ2VzIGluIHY1Og0KPiAt
IFVwZGF0ZSBkb2N1bWVudGF0aW9uIGZvciBwdnJfZndfZGV2aWNlIHN0cnVjdCAocG9pbnRlZCBv
dXQgYnkgU2FzaGlrbykuDQo+IC0gTGluayB0byB2NDogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5r
LzIwMjYxMDI5LWI0LXNpbXBsaWZ5LW1pcHMtcHRlLWRlZnMtdjQtMC05NjU2MDQxZTA0MGJAaW1n
dGVjLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNz
YWdlcyB0byBiZXR0ZXIgZGVzY3JpYmUgdGhlIGNoYW5nZXMuDQo+IC0gTGluayB0byB2MzogaHR0
cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYxMDI2LWI0LXNpbXBsaWZ5LW1pcHMtcHRlLWRlZnMt
djMtMC01ODcwODdkOGEyODRAaW1ndGVjLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBT
cXVhc2ggYSBjb21taXQgdGhhdCBhZHMgIl9md18iIGNvbXBvbmVudCB0byB0aGUgTUlQUyBmaXJt
d2FyZSBoZWFkZXJzIGZpbGVuYW1lLiANCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL3BhdGNoLm1z
Z2lkLmxpbmsvMjAyNjEwMjItYjQtc2ltcGxpZnktbWlwcy1wdGUtZGVmcy12Mi0wLWVlMjQwMmMw
M2E0YkBpbWd0ZWMuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIHByb3BhZ2F0ZSB0aGUg
Y29tbWl0IHVwZGF0ZSB0byBQVlJfTUlQU0ZXX1RMQl9HRVRfUEEoKS4NCj4gLSByZW1vdmVkIHRo
ZSBSSVNDLVYgZ3JvdXAgZnJvbSB0aGUgdGFyZ2V0IGdyb3VwIG9mIHRoaXMgdXBkYXRlLg0KPiAt
IExpbmsgdG8gdjE6IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MTAxNC1iNC1zaW1wbGlm
eS1taXBzLXB0ZS1kZWZzLXYxLTAtYjRhZDdiYjY4ZTIyQGltZ3RlYy5jb20NCj4gDQo+IFRvOiBB
bGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+DQo+IFRvOiBMdWlnaSBTYW50
aXZldHRpIDxsdWlnaS5zYW50aXZldHRpQGltZ3RlYy5jb20+DQo+IFRvOiBNYWFydGVuIExhbmto
b3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPg0KPiBUbzogTWF4aW1lIFJp
cGFyZCA8bXJpcGFyZEBrZXJuZWwub3JnPg0KPiBUbzogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+DQo+IFRvOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPg0K
PiBUbzogU2ltb25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPg0KPiBUbzogUGF1bCBXYWxtc2xl
eSA8cGp3QGtlcm5lbC5vcmc+DQo+IFRvOiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQu
Y29tPg0KPiBUbzogQWxiZXJ0IE91IDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+DQo+IFRvOiBBbGV4
YW5kcmUgR2hpdGkgPGFsZXhAZ2hpdGkuZnI+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBpbWFnaW5hdGlvbkBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gDQo+IC0tLQ0KPiBBbGVzc2lvIEJlbGxl
ICgyKToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBMaW1pdCBhY2Nlc3MgdG8gdGhlIE1JUFMg
ZmlybXdhcmUgaW50ZXJmYWNlDQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjogTWFrZSB0aGUgTUlQ
UyBmaXJtd2FyZSBoZWFkZXJzIGFyY2gtaW5kZXBlbmRlbnQNCj4gDQo+IE1hdHQgQ29zdGVyICgy
KToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBJbXByb3ZlIHNvbWUgbG9nZ2luZyBpbiBlcnJv
ciBwYXRocw0KPiAgICAgICBkcm0vaW1hZ2luYXRpb246IFNpbXBsaWZ5IE1JUFMgUFRFIGRlZmlu
aXRpb25zDQo+IA0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jICAgICAg
ICAgICAgICAgfCAgIDYgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZncu
aCAgICAgICAgICAgICAgIHwgIDExICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX2Z3X21pcHMuYyAgICAgICAgICB8ICA3OSArKystLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9md19taXBzLmggICAgICAgICAgfCAgNDkgLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X21pcHNfaW50ZXJuYWwuaCB8IDMwOSArKysrKysrKysr
KysrKysrKysrDQo+ICAuLi4vZHJtL2ltYWdpbmF0aW9uL3B2cl9md19taXBzX2ludGVybmFsX2No
ZWNrLmggICB8ICAzNSArKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndf
cmlzY3YuYyAgICAgICAgIHwgICAxIC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfcm9ndWVfbWlwcy5oICAgICAgIHwgMzM1IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9taXBzX2NoZWNrLmggfCAgMzUgLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtX21pcHMuYyAgICAgICAgICB8
IDE2MiArKysrKysrLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtX21p
cHMuaCAgICAgICAgICB8ICAgMiArDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCA1MTkgaW5zZXJ0aW9u
cygrKSwgNTA1IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDZlMzc1ZGU5OWQw
YzQyMDE2OTQ4MWZjZDM2MDY0MTc3YWI1NWIwOWQNCj4gY2hhbmdlLWlkOiAyMDI2MTAxNC1iNC1z
aW1wbGlmeS1taXBzLXB0ZS1kZWZzLWUyYmUxZjYxM2QxNA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiAtLSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPg0KPiAN
Cg0K
