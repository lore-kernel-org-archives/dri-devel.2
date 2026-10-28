Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AF606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=U/99MFU3;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=LMdGxbzJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD2310E1E9;
	Wed, 28 Oct 2026 14:43:57 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CF810E1E9
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:43:46 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBfTLW4126552; Wed, 28 Oct 2026 14:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=OCJqv+DIKpuKc9BnGvApId/10OI0r/ejGyw+byjBego=; b=U/9
 9MFU3hqGBeDqUUNlrOLLg1ISid9CrhEaI0hhcumzTr8NwzLHN/n64s7YDVaZUpuC
 CViTYo+4N1KTLz9LmQgPC7unbG7bIw2hOVMapL5PYayptw4eblP2oE3R4FM07xrD
 wAuV8H+tpNvpq0jDGvCSXgOnzUAQDuL+PTJNei66EtXVqpXZiFIsn9BRT1jlbjjK
 sRJxe4kFuql0NBdbeIMUz1adELqQWPzJz1Lrnl3o/BEM1UFRd9x/2ptTBDPWc8r8
 ljSRub/4Fx4/XD7FoYh/O00JVZ+7DMIpeXydkCTbqIhNj0JRafUz88nsdHWmBEH7
 VxKP5IC971amzDUSA4w==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021077.outbound.protection.outlook.com [52.101.100.77])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hk414gkxe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 14:43:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc1AT4YD7Vr0bBQ1RfqWq8nFBgMn59nbQc/ehHeC6LxzVHc7LOoBdwQugfVNvt3i8q9XbEguNl6p9EBHkmsOsr+umR6UGQNn0noa8nyvUYwZU0Q4sJh6cxkbwPmz/hO8Ifp/tXUfshVV7MnNois+m4oQsyEd/Rntny4RiuqQ1GEDAOjQMEL2yqsEgDVwy/zw6mSW0CzBgAltaolGFTtU98loBy6e/db6WeBbgr5s4E0CbUbRgiJp6gFH7pa+NILWBRKhEutpKta8tIZIVmMADm5Rq5zWYkXD0CRG7QZkaXzc3ORK66LWioS1yNHXQDwyNPw4TrmW3IsBx3JQMuDl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCJqv+DIKpuKc9BnGvApId/10OI0r/ejGyw+byjBego=;
 b=ZkHdUS7i5/Wp0j3g51kzZXMmRBb246HeoPAWvP5sC0Zyax3Vj3yIEZHSR1XLxOgCtC3eql758bGQWCgY6LBqamWjS6E1kEdo+lv1rtXlNqXkDmKsL0R7dhQ8o5bOlBfcNC4ky/pAENXPNYc7KWyJOF/jyQkAyMy6A5WUhDceBil2EcWvmZ4o51eCE7/KjiHwX2T1QyNaBbHrM232Fd4BFX7l/1ptNnWp5J5LIrjZUy+XQt2qEYPNW2XIsN29YuLa8JaZyVYGEmE7aHJcmP+665/pJ13W6mAnyLW6IN384KcBDUxsI2E8c6EClQcaTxjx4mfzVuCgXKItAaPrNBbHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCJqv+DIKpuKc9BnGvApId/10OI0r/ejGyw+byjBego=;
 b=LMdGxbzJTPYMj05a1jOb8WBen0JvMA08TZE7m6L1EX0hgr9fu13ln4RS8C+dBqlBNS/CkNPv2t7DX93C6OIX3ZjD2dpefJ8lwSxZEBCwlLacKg8dg3H/Cd5tInamKmoDjOJa9u+YFRnOOORshHf/7HLUJT/NhFvoIlik72pgMW0=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOYP265MB2078.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:43:32 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 14:43:32 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "m.wilczynski@samsung.com" <m.wilczynski@samsung.com>
CC: "lkp@intel.com" <lkp@intel.com>, Luigi Santivetti
 <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>
Subject: Re: [PATCH v3] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Thread-Topic: [PATCH v3] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Thread-Index: AQHdZuq0oiwGfS5Mg0W9ppeKNRxLig==
Date: Wed, 28 Oct 2026 14:43:32 +0000
Message-ID: <29ed7e87285e39dfcb87c07d3c8a17361277f878.camel@imgtec.com>
References: <CGME20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499@eucas1p2.samsung.com>
 <20260810-fix_imagination-v3-1-e512359722fc@samsung.com>
In-Reply-To: <20260810-fix_imagination-v3-1-e512359722fc@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOYP265MB2078:EE_
x-ms-office365-filtering-correlation-id: c58d87ef-f8e5-4113-5984-08df3501d6db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261022075727099003|261022115727099003|10067099003|56012099006|261026140227099003|22082099003|18002099003|261026121527099003|4143699003|38070700021;
x-microsoft-antispam-message-info: cxa0J4y2EOsuejg32h8SJs5ToyoO7Dd2t/fmMsybLaZO9PIXwVM2AEgvsygaPMNmpluIRydbjtsnln8p7IcCOE/M9pXGBaQlFzmjjdn11MU3QgvEs9vO00WOUqiTUtlyOFMY3YnxkPJSPFTxHtbjlfveM9yHbCaHK8SJh3TBIhhuNoZIvZmMeYeWXIoLfs/lu2B4ml2pKmvfpfYgUo1NfkdAfqHiKUsXNCpcnVyipglF4ZfIp/iRqkJw2EGdlLw+8f9He7O8RPLbwgp0iNPzj7koIQBL+Hs7VBthhCzIXeZnwGMqarS5/nD5GxIsaR/eu5t7yClUlwGhMJQf6/g4ZADzttJ/AYdmtgmhzYBaXHzCJ8TsJvnefWeBsDaIhGJXLsAuj6hiBDMQlllrfo6nr5S/336c7rjHpPpJy+dsMXRQu9+ifas3aPeIWL2jbqxDpSnbwbF42Ke2OwfOZ+lBd5ogS6vbKSKknNC2puIhSJgByaReF8wAHjhvGbXOKfCqGaqP383kOfyxWDP1gFeGmDIZvSF87MaeI/O2p8fWE1XUXyflUk7Z1FB+uBrFYGds0CyCjcOkVZ5oGilDW/C7wwjlMdIVWThDJueEh7pA+rUnvK6e0CEAZKsbWyfQUppUWWcYoxe1sfMTZguZ+XLy2x46YjVsyWZA+1P3hZFuC3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(261022115727099003)(10067099003)(56012099006)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUxOMVBSU2lBK1phQzlscEtaTCtIZCtxNCtKM3ZVdTVsQ2M4VE9hVEliNVhG?=
 =?utf-8?B?YUo3UCtMRFlNNFBmcEVRNXZhUlFUbk5sQ2hwcXEvVU1nWUZlQ2w3OEh1RE5S?=
 =?utf-8?B?MWVMQ2ZTRVVzUkt4dnBLUmJmdXQ5UmNybTBiSzRQWTNEdmViYkRqd3BjUktD?=
 =?utf-8?B?Z1lSc3pkcmZnTmxwaElKVVY0citsMVBjNUk5MDVWTWZpdXh0REN3bzExeTFF?=
 =?utf-8?B?bWlML096T3d5VGtCYmordkwzUHFCVUxsMVQ3UEhJdnVqMTVMeUV3SER3YUJK?=
 =?utf-8?B?enFDOHNsVWczcEJZNlZXTWlUNVRJQW9uZ1ZLUUNGbXQyc1NoZGdXdGtySFBG?=
 =?utf-8?B?K3g2aDJtMW5Pdjd0WDNDMlVPeVRCQTEyK1JadVdyK1V1YThxUlpyU3d3KzRw?=
 =?utf-8?B?N3QrRnlzbUxweWRoQk4rNVpRTHdYY0VNZlRwL3l3TC9ZY2thY1REb20rTHhp?=
 =?utf-8?B?aEt0dHBoaUdWdzdjWm13NEh3MFVhMzBab0tHRXd1d09ZYzUvZCtxVG1udE1v?=
 =?utf-8?B?WVYvc2VUQzEzSFduVHdYQlUvUnQrMVplK00zYXo0UmNiaFMxckJKRlV5cEhs?=
 =?utf-8?B?SG5wSDNITUlCR0NOanhmNWFBci9GV1R6MUdkR0hsTHJBSlFRNWhNOXhWNHJw?=
 =?utf-8?B?eElSL2lGQ2p6K1RVak05L3ZLc1c0dG5oR2sxNVFwMEltVko3SWt1M0w2RTZp?=
 =?utf-8?B?ZjBQOWcvenpsbk1YSnVrL0RaOGtXS1ZsWFZ6NWRibXpDblBuZW5yeWxPeVhH?=
 =?utf-8?B?d3AzZGFIK1ozTHAwMGd1RjZIbFQvOTdMaHRFM0t2ZzRJNEVueXlzOU9JOUtS?=
 =?utf-8?B?WnNoZ0RVcm9Da3dYaGZJNzFLR2lsQjNsRXNxbEZkVWpLZWJBRmVFc3FPMHMr?=
 =?utf-8?B?OXd0VFJUdWdaeHpyQzFUenJTUFZmU1BobnRoQ2lDNnY3S2M2ZjFITHo2NnNO?=
 =?utf-8?B?aitFV2diczNGUUhOWGRlUkJFRGVqMFdHZTVTMTh1Q0NZb0gvelhnNFhGK2dZ?=
 =?utf-8?B?Qy9lYzZqSHJDN2xNbFBlUkhlNzNPdzRMYVkvODM0bHpoK1ArdTZrU1lNUUpt?=
 =?utf-8?B?ODhMYmc3MG80cHJQQ2s4Mk1vaXJOUE1mTHFSZ0dzVG41NUFhMStPTUNScGlu?=
 =?utf-8?B?SEViSzJIeE1ET1pXYTFsZGcySXltVUc0Ty9pVklwN2dmV3I4Rnp0dVErMGF3?=
 =?utf-8?B?OHQyamVoamVQTFVObGl5NmFvRGlJMGl0Z1RCTVlOQTlhaGhDa1ZhS29Ma1Jr?=
 =?utf-8?B?VnFvczFqZG1ZbHNJNmQrK0NYc0RJRXl3QkpzVW5PUjNzUzFhL3E0WkVrajcy?=
 =?utf-8?B?RmtwZitmTnRqWXArU3RsRW1IZ3pxL1d6N2RIMEJ0ak1vSVZEWXBQYnp2a1lW?=
 =?utf-8?B?MkFwMGVETnFQNWh3Y0dRUU9CNkV0SE5Ebzl4d3AvQlhrT0RVWFk2OTNYRjNH?=
 =?utf-8?B?ZDdnT0FVbjlrZTFpaCtMVHJiWGQ3M0JSWTRjdVBLMUg4SXg0MHpiSVdMOHFq?=
 =?utf-8?B?MVM3Q2UybEo3SnhHWmtaSHE1TXdQQ1dMK1RKZm92VnFsemp4cmpRUDkzZ1ox?=
 =?utf-8?B?bWFJNHpmN0dXQnpIWGNzNDM1RkNTZGM3cWF0OTZGMU8xNjlGV2F1SmFqZjBB?=
 =?utf-8?B?bEcxVlBUOGI2K1haaWc5WkNyOU01dldvaytGR09IRWg5dEZKVWUvb2w3aEt3?=
 =?utf-8?B?Tk13R0JWblQ4VE9JZW1OR3YrOWh3dVNwME8zR1lVbGNpT3pCaFdSMmt4UXFB?=
 =?utf-8?B?THJJdGZ6cU1IWkVaUW9RRWRoRDRla1FqVFp0Rm8zUUdZYmFkbm5iMVZqeldC?=
 =?utf-8?B?VXY4Z1MzazJaU3dTR2NhYnFkMGVoeDVrY0ZxamR5OWRRS0ZhbCt3UytHVlhE?=
 =?utf-8?B?aE9Rc3pUUHI5QlRXZkNXM2I5SXZPRjFHaDluckxlZ2hSSTBPSktSR0FnaGcx?=
 =?utf-8?B?VURTN0wzK2RSeS9LdU1kR1BBbEpRTEg3V0tRMDBFV1l1RjJWdml1ZmJKYjNL?=
 =?utf-8?B?aEdtWE1KL0FCTGNQTzhYMXVPMU5NMmM3NlU0WnJrRkxkYVFUeDJvdTBGOG5H?=
 =?utf-8?B?bUE2Nyt2NzFBcy96T1dod2prRVNGRGMwbDZDb0xIUG9raEt4LzZnSnBiQVly?=
 =?utf-8?B?Z2d1b0hsVVMzYm5oSkh5VGdlakVUeXAvTlFRbVhXU2JqNWlGWDFDL1BDWER3?=
 =?utf-8?B?cUk0NXRHdHlhaFl6dHYwZXF0bksyUURDbGplTFpUN1loRFQ1eU5NbVVib090?=
 =?utf-8?B?WEI5ZzFzT0VKS09rN295dFAxLysrd1BEM1BnY3AzVGgyV0RXOFNTU1M2SlJE?=
 =?utf-8?B?RWtLMjhoU1NmS1Y5d0xnLzM2aTJsV004cTFrWFVMNlpOSVYzb28rN3E3V0py?=
 =?utf-8?Q?V0CgDwJls0iPO0sI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67A938AFB8DD64C8180611C1E721BB7@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: x96BBufTkRELE2MNcPsjDUvXTC+9+tBJg3zRK3nc0O6xHQ7BLgeUitUwDUcKQM7avevzppe0jhSVLX0jnKHc0RY0Q2HH7lMlRtnMEbjJXevjX1O4pZP3nKfCLt4v3ilRWsOfOygHnnk/3hFWsZLvMDzIcuu0TX6+khep6uX8jSyZs38yXaBSLOpjTdXI5oA0pEPoY9JsbkxisHmfUyWvDOL+Sf7B17iq4pOUix4gLhVFEmBYwkyXhrdPcCMmfuRn2ho2tpThbtehCv6zL216OsP/RSmo7HxQ1cgUWJGVQbiLaAY2kgVBUhEmm+/kQPHU3yaj+EslOpu0URFZ2dYrwA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c58d87ef-f8e5-4113-5984-08df3501d6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 14:43:32.5024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJtmyWY5A5KlqLt72H+xQHRZDy0aqaT0YBQ8pcLzmIy2Sou5IBr3DKPZ37fbVWNhtY+/RAbvIO1FdsnNlfMvG84P82gvRhKNsTPk4tV/X/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2078
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX966ru/74tKWs
 YWUkR/g+TohoA7geyXS8Jsax+07UgkOIFXjEqhAtjFZGh3MILj+MFA4DHK0Am3sH8O6rNTz69hQ
 vHGMG/HrSY9ZK5igVYWhXB9iv5TGvps=
X-Authority-Analysis: v=2.4 cv=AMk9Hd7f c=1 sm=1 tr=0 ts=6ae20a17 cx=c_pps
 a=FLlyU76OtWfqjC5ipmjW8g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=r_1tXGB3AAAA:8 a=hD80L64hAAAA:8 a=Us2G9mFh6sP1UL_tPTwA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: y5qGHp6wCL-PpijzV0gRDOfIFi2ID5t8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX9xDMGQYYC04x
 x2GVc0h/WHq10psnGKsl4NITxDsRTewdFmKWK7atrwuEoLeN3B91o4SVdeBad0/M7OAqEXAsvNJ
 bQYDlhV53ccmP1vaj0FsgP2K2IrrJNiugG7s5p/rG5rOaUljIe05IPH928mxOLloDsELjyKmsKM
 ihjn3bRKCBoFhLUZgrUguqlkfmlYy2K1UYClqaW+bJ8+Z9hVkDJlaBy14uvWDrD0+WeSwuSEude
 DExslKqARgVJfWW/Uj/h/MZ9VrXrJ2lMzwFwCxT0EVSktfoQ8qD471xtaMBG21+s/5cElvkDQ1e
 3EoKWZyPF7eUtLpQzXoScC8rEucnXCHh3bz7Wifa6QU/a8BJqlHeSRXQc3fEg/sothtR0owo490
 P76QfScWL2h+Hcz2v3lhJrzZ7ouVSS2COyQMGzrsJvBh0yJSUz9yoN9FIwfggaYviVOZUFpCpZh
 no5Kda007xow2krk8Tw==
X-Proofpoint-GUID: y5qGHp6wCL-PpijzV0gRDOfIFi2ID5t8
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

SGkgTWljaGFsLA0KDQpPbiBNb24sIDIwMjYtMDgtMTAgYXQgMTI6MjAgKzAyMDAsIE1pY2hhbCBX
aWxjenluc2tpIHdyb3RlOg0KPiBUaGUgYnVpbGQgZmFpbHMgb24gUklTQy1WIHVzaW5nIEdDQyBi
ZWNhdXNlIGBTSVpFX0NIRUNLKHN0cnVjdA0KPiByb2d1ZV9md2lmX2h3cnRkYXRhLCAzODQpYCBl
eHBlY3RzIDM4NCBieXRlcywgYnV0IHRoZSBjb21waWxlciBnZW5lcmF0ZXMNCj4gYSAzMzYtYnl0
ZSBzdHJ1Y3R1cmUuDQo+IA0KPiBUaGlzIGlzIGR1ZSB0byBhbiBhbGlnbm1lbnQgY29uZmxpY3Q6
IHRoZSBpbm5lciBtZW1iZXIgYGNsZWFudXBfc3RhdGVgDQo+IHJlcXVpcmVzIDY0LWJ5dGUgYWxp
Z25tZW50LCBidXQgdGhlIG91dGVyIHN0cnVjdCBpcyBleHBsaWNpdGx5IG1hcmtlZA0KPiBgX19h
bGlnbmVkKDgpYC4NCj4gDQo+IFdoaWxlIEdDQyBvbiBBUk02NCBpbXBsaWNpdGx5IHBhZHMgdGhl
IHNpemUgdG8gYSBtdWx0aXBsZSBvZiA2NCwgR0NDIG9uDQo+IFJJU0MtViBzdHJpY3RseSByZXNw
ZWN0cyB0aGUgOC1ieXRlIG91dGVyIGFsaWdubWVudCwgcmVzdWx0aW5nIGluIGEgc2l6ZQ0KPiBt
aXNtYXRjaC4NCj4gDQo+IEZpeCB0aGlzIGJ5IGFsaWduaW5nIHRoZSBlbnRpcmUgc3RydWN0dXJl
IHRvIDY0IGJ5dGVzLCB3aGljaCByZXNvbHZlcw0KPiB0aGUgY29udHJhZGljdGlvbiBhbmQgZm9y
Y2VzIHRoZSBjb3JyZWN0IDM4NCBieXRlIHNpemUgb24gYWxsDQo+IGFyY2hpdGVjdHVyZXMuDQo+
IA0KPiBGaXhlczogYTI2ZjA2N2ZlYWMxICgiZHJtL2ltYWdpbmF0aW9uOiBBZGQgRldJRiBoZWFk
ZXJzIikNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
PiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNTEyMTMx
ODUxLjFXTlhrM0JDLWxrcEBpbnRlbC5jb20vDQo+IFJldmlld2VkLWJ5OiBMdWlnaSBTYW50aXZl
dHRpIDxsdWlnaS5zYW50aXZldHRpQGltZ3RlYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
bCBXaWxjenluc2tpIDxtLndpbGN6eW5za2lAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiBDaGFuZ2Vz
IGluIHYzOg0KPiAtIENsZWFuZWQgdXAgdGhlIGNoYW5nZWxvZyBzZWN0aW9uIGJ5IHJlbW92aW5n
IHRoZSBhY2NpZGVudGFsIGI0DQo+ICAgIkVESVRNRSIgdGVtcGxhdGUgZnJvbSB2Mi4NCj4gLSBO
byBjaGFuZ2VzIHRvIHRoZSBjb2RlIG9yIGNvbW1pdCBtZXNzYWdlLg0KPiAtIFJlYmFzZWQgcGF0
Y2ggb24gbGF0ZXN0IG1hc3Rlci4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gRXhwYW5kZWQg
dGhlIGNvbW1pdCBtZXNzYWdlIHRvIHByb3Blcmx5IGV4cGxhaW4gdGhlIHJvb3QgY2F1c2Ugb2Yg
dGhlDQo+ICAgR0NDIGFsaWdubWVudCBjb25mbGljdCBvbiBSSVNDLVYgdnMgQVJNNjQsIGJhc2Vk
IG9uIHYxIGZlZWRiYWNrLg0KDQpTb3JyeSB0byBib3RoZXIgYWdhaW4gb24gdGhpcy4gQWxsIHZl
cnNpb25zIGhhdmUgdGhlIHNhbWUgY29tbWl0IG1lc3NhZ2UgYXMgdGhlDQpvcmlnaW5hbC4gRG8g
eW91IHN0aWxsIGhhdmUgdGhlIHVwZGF0ZWQgbWVzc2FnZSB0aGF0IEkgdGhpbmsgd2FzIG1lYW50
IHRvIGJlDQpzZW50IGluIHYyPyBPciBhcmUgeW91IGZpbmUgd2l0aCBtZSBtYWtpbmcgdGhlc2Ug
Y2hhbmdlcyB0byB0aGUgY29tbWl0IG1lc3NhZ2UNCigrIHJld3JhcCkgYmVmb3JlIGFwcGx5aW5n
IHRoaXM/DQoNCi0gIlRoZSBidWlsZCBmYWlscyBvbiBSSVNDLVYgdXNpbmcgR0NDIiAtPiAiU3Bh
cnNlIChXPTEpIGJ1aWxkcyBmYWlsIg0KLSAiV2hpbGUgR0NDIG9uIEFSTTY0IiAtPiAiV2hpbGUg
YSBub24tc3BhcnNlIGJ1aWxkIg0KLSAiR0NDIG9uIFJJU0MtViBzdHJpY3RseSByZXNwZWN0cyIg
LT4gImEgc3BhcnNlIGJ1aWxkIHN0cmljdGx5IHJlc3BlY3RzIg0KLSAib24gYWxsIGFyY2hpdGVj
dHVyZXMiIC0+ICJvbiBhbGwgYnVpbGRzIg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLSBObyBj
aGFuZ2VzIHRvIHRoZSBjb2RlLg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfcm9ndWVfZndpZi5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9yb2d1ZV9md2lmLmggYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX3JvZ3VlX2Z3aWYuaA0KPiBpbmRleCA1ZDU5MGM0YzI1NjYzZTQzMTYwMWRkMjY5NDQ0NjVi
NjJjMzE1MjZiLi4yZjhkYWE5M2M5ZTY4MzJiYmVlYzc0NjAyNzVjNGI4MDM3OTJjYjAyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2Z3aWYuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2Z3aWYuaA0KPiBA
QCAtMjE3NCw3ICsyMTc0LDcgQEAgc3RydWN0IHJvZ3VlX2Z3aWZfaHdydGRhdGEgew0KPiAgCWJv
b2wgZ2VvbV9jYWNoZXNfbmVlZF96ZXJvaW5nIF9fYWxpZ25lZCg0KTsNCj4gIA0KPiAgCXN0cnVj
dCByb2d1ZV9md2lmX2NsZWFudXBfY3RsIGNsZWFudXBfc3RhdGUgX19hbGlnbmVkKDY0KTsNCj4g
LX0gX19hbGlnbmVkKDgpOw0KPiArfSBfX2FsaWduZWQoNjQpOw0KPiAgDQo+ICAvKg0KPiAgICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKg0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBkYjJkZGI4NzE0
MzUxOWUyMGE5NWFhMzZjNjBiMzYxMDdiNzM2YTU4DQo+IGNoYW5nZS1pZDogMjAyNTEyMjItZml4
X2ltYWdpbmF0aW9uLThlZjBjOTQxMjJjNA0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=
