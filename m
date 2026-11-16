Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC265606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Vbme+41d;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=D+85Ofwc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D2A10F142;
	Mon, 16 Nov 2026 13:12:41 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4938810F142;
 Mon, 16 Nov 2026 13:12:16 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AGDBG1P021962; Mon, 16 Nov 2026 13:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=QnOU3rHGxqBySNTJjqjoET6K2WYMPRhJK/NRwqXCzVk=; b=Vbm
 e+41dmgZhRpS7T9XHzGSTpdqx8Ak1+y89ggJK3Yu1fK+r5XQyyvV3Oe+MSVYPzEC
 stRPPzSIdHUSvj2Wk88e4xJ3U2OEi9N4H44FzDBEzwls2JMBgeDtV1z97GjGvICo
 pHwblueNeZGv26OE+55+gOCapAiV4kCR/l5y/ny8lTmzHbqXXxeclu4UXbzXJEai
 N+lslADZ8Ovld/+hzMmwy0o8yEbPEZpgp9aPqOL4CTFJRiXhjNCmKmCwA+P6I1Uk
 dHEtM71nfPM8Nhi4XyLFBX6YwParIUKTHwbdmE1Ao/DVcOSMyuSjuEoYBzWgVu9D
 4pksM0vV6ii7W+vnlXA==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021102.outbound.protection.outlook.com [52.101.100.102])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hxestse3u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Mon, 16 Nov 2026 13:12:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxZ8VPOyXV8YNEwlBZLMS6JjltMZDvZcOdmXz4Og/xLE4eckfo3VRnPxlLMF5q4oS4WMWELNo2F7cpygxKq1L8oMpSD2vf6YPlXkUF6GtVqCJhVZ8NK34M6Cv9FpYymNHUrB2uJ42ZBW70MfqQe7QUr98ZAvuMj8RMPvFoW50wJOixZjkBmi3qjc2TM9qAe30g6x75GSp7EiADactqQt7yIXGyer4Ul6g7Za/uEiHrkTgFSnfJSU9vcCA/IymdFeFFpVMI3jxrDNDobU1OUCa1jVLb010PHa6/ISvZ9Nt52qg4TS+rf05d5wOJdvQw9IyNJij7MHHEapF5yf5ptw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnOU3rHGxqBySNTJjqjoET6K2WYMPRhJK/NRwqXCzVk=;
 b=qqptVMOEk6CNbv8uNck0v+NyhzNuGgLz6iJpky3KS2b7qvDoQemzh4YGEqVrYxAVlaDaw29KNnegeR7hi/6pFeq35deu/scXp8wp8+8ZHtdjYxKjh+3gzREuzWy3pJ9nwH2MqxTvCn1qFJEiWrokm9q8K7YdD667wAU2m18l/iLlGeApwegWC39qcI118D6SR/01dwa1xP2QtSBtiryLRQST3ZlKxDFgkjmA7lGIUEBIj7BOZqFeIx8Ex7RZV3u5kNZJ288CDnVrDZBIpSxGoPeTE1tYkcqZQcXGzRjaefMVTrItQQUtE6BQb6nPrU1iLGnDRMAWwr4mRUDYIOZdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnOU3rHGxqBySNTJjqjoET6K2WYMPRhJK/NRwqXCzVk=;
 b=D+85Ofwc5ae0N5N3dfPjLeSd+gRTjP6918p+ojcGF7gpsA4JY473GbsiuIWHBBnBkkR7DvzOLHcpqiShEdJIc4PQvbUadsgU/LDnJHmHDM0n0zYyxknJ7gSNZcp8PJ0gNCpoTU+/4GaFJhb+Ir83hR2Az7DpnV/Hg7yI+1nzibk=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOAP265MB8982.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:493::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:12:03 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:12:03 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/imagination: improve DRM_PVR_DEV_QUERY_HEAP_INFO_GET
 documentation
Thread-Topic: [PATCH] drm/imagination: improve DRM_PVR_DEV_QUERY_HEAP_INFO_GET
 documentation
Thread-Index: AQHdbSCoVyAHNN6AOkuWUcp5r55tz7cwveEA
Date: Mon, 16 Nov 2026 13:12:03 +0000
Message-ID: <a404e000648cd76b221441a78d2acc1914da1be1.camel@imgtec.com>
References: <20261105-document-drm_pvr_dev_query_heap_info_get-v1-1-b899401606e4@imgtec.com>
In-Reply-To: <20261105-document-drm_pvr_dev_query_heap_info_get-v1-1-b899401606e4@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOAP265MB8982:EE_
x-ms-office365-filtering-correlation-id: f46786ee-564a-4099-39ed-08df43e334b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: fg3SEyd02YaozjApbr8tHSrA7oxYjg229PjrgC54hIH/OyMEE07kj+SlJrBpUpLIbUikJsCeLyyZyEY8WckhjrxBihsRBPU80PmDUlZYGxwcW3xGWiJZPlNZ/TtB7EL2xUiRZBV8REGxRGRoSNTs+wgtscgVmMJEUCRq+g4br/4mGxGnohtHvnI5D6xX8Sec3zx8nNsJ6GlK9n7kR5SvKLxln8OKGzRQVfqVQduVh8tOPvM9GhUdNcBusc5QYY4sYzJRwM2R+LYKF0NYxmoo+ei90rykmaQdgwDjC2m0BGzvo8Hahb1dZeGm15kQ8tyffdLSXaNr8VdpG5kru1wwWJ0dHwlqO4YPK7xNfMHVn9dn5CEw7L+UQrHGsMTjl5DFqwLEBRwnKmwKHIPyzrvxHl4kqvG8W4QKTOeBVaCP0s+VDmgdvquofFDDgITaNBQ0dM4SCdKgM4rmBm4n2zc99nFz2Vn8QOrDBo0Q0IgPW9SCU74QtJsttToIiP1EjvCCRTg7i8NtOcrcMzpjH9XlJmOd+3I4m3Blr5bwUTTUpNw8ncQau2Xp6GPU1u8vKSgaShnZgI0RH/bBUnNkzlHPT0eZAinVzUfpm8zMir8LIGjuyQGBc820MkBg3JJxSlcbUQsMNZjuMur3riu6W50rBenGqLKlbldzCRWPqlgJT6TicPWVY+lL63IZlqM3fVpceqHzlCFWDSVPs51g713nbuxfjz31nqDoFAblvLEHpxY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG5IcHJNMnpmNm52ajloMWN2Y2NYejJ6T2ZQRVQraXNKQlpOWk1jUmJYOXNj?=
 =?utf-8?B?ODZHdlp3bHlFdjhCODlvS3Z1RXYzSFdHdUd4VmV6Z2JwSkN3d1QyVk1NWTY3?=
 =?utf-8?B?ZytMSENheUEvMTVuM0JCZFNQc2pvcStseEZMN1lvKzEvOFozSUlHNmRYZGlz?=
 =?utf-8?B?QXZpTEF2UlptVGc0dy9XU0UwQVBBN3NoVnZGMVhzajNWbEwvL3ZibkxIcTBi?=
 =?utf-8?B?SEdVYXRlQ0djN1NkR2Z0RytFTHFlL1JUTTZWN1dHVm9MTGJ0THBLZk1iSVpp?=
 =?utf-8?B?aVc2a0xxMXVvSzByY3ZMVy9GQW1YeE40bXJPVEFKb3hidmRGZnMxamppdUJk?=
 =?utf-8?B?dUNxODBqYlBoMzFzZXlVcko1a213MHJ6bmV4RWpySWJsOExaMWIxQjh2Rkx2?=
 =?utf-8?B?ZnFKMVNsYVcxczdaVVNKZithN0ovTS9EdW95TytKd2hmVFZFUGRYTDNLNU1w?=
 =?utf-8?B?aXhXQmZ6UTE4R0JSVUF2VWQ1RjB4UFZmTVQwSWh6YlZLWUNMNGlwbHlQTlRy?=
 =?utf-8?B?RjIxSytJbFdqYm5aTnhKUTBnN25MZ2FaeFpRYWZ6YnVCbmdRM29od0Fxak9n?=
 =?utf-8?B?Rnlja0ZXbzQ1T0h3SjhReFdBY2ZjYzcwRzZpRkEvWi92MithWHhsN3JBamhU?=
 =?utf-8?B?d1czeHFNY1hhMjlWeXhxd3p2QmR1VGJEWUJMUWcyQW50UWRXM3M4eHlDNHhP?=
 =?utf-8?B?emhhWER5OVpNU0xKSHlRcGJndVhUcTQwb0RodlNLb2FsZmxMZ2hPRHdVdklt?=
 =?utf-8?B?dlBnRVVJOFBlK2pSLzFyMzB6a0tFOVlEUHpWMk1GRGVUaUlBdEpkdk5VTFN6?=
 =?utf-8?B?QmdXUlU3bHo0WDgwN1o2dVdIdTlRYkp3eHFDMmN2S1NTUjBUcEhnVExxLytO?=
 =?utf-8?B?OTlBMnpUdkFBa2RGNmxIMUdQeUJYWWNXMG1TS1c2cXZ6bytzTS9xSFRUOFAz?=
 =?utf-8?B?bFlXTVBaQzdWeHhhbEYvT1pYK0lXaXJQMUtucWtTQmhPWWV4MGRTMGQyUHVU?=
 =?utf-8?B?d25aWkd3RjR1MVhPZ0R4T2loaXNhMjRsbWVVYVNvbkdmZWlBNWJ2WTIyblEy?=
 =?utf-8?B?cnA1OWpIR3N2WWNlVDgzSzJncGk2UE5WSzVqYUpMYkdkR0p5MUQwalIzQ2xY?=
 =?utf-8?B?OHNJaTJIMy9RV0hjVk9YVE5wTHc1NHdtT2JLMXcxTTJVSDYyQVFhLytSMTdh?=
 =?utf-8?B?a0FqZkpMbkM3Y1JxOXA4WlZudmFZUG84bm5zbkxMc2ZUU05YSHdURG96R2JE?=
 =?utf-8?B?aWM4YllIbllJOUhyVjZRQis5S1dyaEpBYkRkYnlxRzlQbWN1MXlmZThBaXNZ?=
 =?utf-8?B?NTZwTlJ0SFFjdVpxWFdsM3BHOXZxaUpCZFovbnBiUGdLSUFHbXROVmxNM1Ar?=
 =?utf-8?B?OGY1N3ZobWgvcXAvREZTTjd0TVZ2UDdhYkVucEFwS055UnhsVktML2JtMWJR?=
 =?utf-8?B?ZHRyU1BzUzlRSDdKeElPNVFONmZRcDlxWEZDZERoMFA3cDY0MG5GZWNDY28r?=
 =?utf-8?B?a0xYZFNkaXAxeHZsdXhXdFJ0WXFsL0R5Ujd3YzRtblBaVmJtZmFSYVFVMEJx?=
 =?utf-8?B?RDdYcC80VEN5U0R2anFwZm5TdVNRSHQvc2l5S1FPSkdqRWw4NkFISFZtRFBm?=
 =?utf-8?B?a1NXdVZZNDJ0ZTcrVDJuZzFmWDJDcGhFTXFtUEFWa3pyT1pSV1hFV2N6WldM?=
 =?utf-8?B?b2FWa2tUcG5vM256N3JuZU5ISWo4aVZ0alRxZW9RcTZWSXdxM0hhT3h2RnBl?=
 =?utf-8?B?eGFNOFhua0h0SWd5SDlBc3hvelVtWjN3Z2RkSkZGeWM0UzkxSTV6b0pQamZa?=
 =?utf-8?B?RmVlRUJ1UUl5Z1JWeWdMcmJIWkZsQUdVMnEzR2E4bTZJMkpBQWZ4QjBzRUFi?=
 =?utf-8?B?MUozUWp0Q0FWRElCUWFPNDlBSHd0cmVNR2xLSys2WHJwdGt1dzh0UFhkaUxO?=
 =?utf-8?B?UlNySi84T25rZk15bTFRbk0rb3J2V1czVnMxeU9UOEpVTkV6V1dmd0hzNHJj?=
 =?utf-8?B?eFJWYTFvVGUwaHQvMWtwYXJjcnp0QTI3WVpMSWVjZGhDWjF2akp3SzNneTls?=
 =?utf-8?B?dzdiTklPTTRlbnArQmgxbVhXd1o1K0lJeTRROUJmNkZ2Z3UxK0kzZ2xGNVhn?=
 =?utf-8?B?Y0w0MWc3cExjTlZGYWpFRTlHSkM5ZGpsdy9SRzdtdnhvelo5bkFLRC84MTdT?=
 =?utf-8?B?Vm1uTFpDaWc2YjBDQUR2NXZwR1lqWm4zMmNUamN5dk9kN2JzM3lQeklid0hJ?=
 =?utf-8?B?b2sxT3dEcm9TWGFrUUVlS2F5TXRUWStnaVVnYytXSUNySTg5akZ4aGxPVzcw?=
 =?utf-8?B?RHluWmgxTzZPRUpFNWovWEZIdlpBTkUxcXUvcDlkZkN2VEI2WlcxMVJUcnhh?=
 =?utf-8?Q?9HC5WEkFzNHS+AF8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F75BB346D8A10645B340DF5AB9714AEA@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xtdjz33ypQebb24rJA1xfMhXd250UImcKy7lPKBv9xe871AsxdNfRMW7Ylh7C3lGJttqHsMgD9VEIjY+1204JwjgzyXfTZbl04ZGskMz15bSbvtMeaiXrE9+iqVYEjSfpuhr64l0jxaHUmlHLz/nO70lhuzB41kv3h1fgbFs2XsyoXpBrcXMtmVnu6Aq0/4ilvksiNlkDGc6Mssm7dz+M7Pbbr+MpTUStqBh1GQIqtkQJYMS3ChjbEK5BzkN6aqz2zMUkf2fVC5c++Ic2mgQikvjwK8e5nXa+YEUeQwcUjB2xXpRwaMgGAmyrQRYUGRcKWHyjkAM1AsIKacubBhGDQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f46786ee-564a-4099-39ed-08df43e334b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 13:12:03.0841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPU0pnR/7aNog6UUTfGibQJ11Qmx7m7pDIjJl96s5vu1nAVlZcCsWA5Jy/V03JTIMhCx9bIxEmjPUfWDaRLB2UCiT950m78R2kwhGc7t/0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8982
X-Proofpoint-GUID: PmH9vwp8mUnWG8kyHdd4Yw47Rpx_TxIp
X-Proofpoint-ORIG-GUID: PmH9vwp8mUnWG8kyHdd4Yw47Rpx_TxIp
X-Authority-Analysis: v=2.4 cv=O8OsLx9W c=1 sm=1 tr=0 ts=6afb0127 cx=c_pps
 a=DJFj0GTOdJdpJdTFdBr2OA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=Guxo1dFHkAz60wmGNoYA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfXwlD0Tk8G+ypN
 ZcMNzfBeZS9aOj0FcYrAK8GW7aT3K9lJ/NhVT7CGJAjOpKo6WLKo7C4AQRzWPh0aVfSZtwDambb
 TXFgZHHAqLj8xvODzESaJF/MgbXLNFq4V9lKtdDBmRV4gcJCet6ciWdUe+/tCkFB/De4SiKn0Fg
 fzPlS0SSajEz7npXvbY2atluFO6kMH9ZQxOT1B1iVCYnoNrX/z7jSIKaltjPubYJ8fDQ0o/30iX
 uM3EELS3XMi417E8WBNaYUqjf+QBOuHXuP1vlXgEkVPOtm3jSj2MmEsQH7Zt6eVOzeM6ranKUHi
 rX+GQyjnkqGyK6nFyPlV8uIfsEg0DS2ce3g3qtMJGhkUf7rHfRmdR2Fi5JL1h1dUHiDH/TQz1sv
 H1R7rZ8hjViLMYAiB4JL0pUm40jV2z9n2eQXrtyx12k/F29bG3dcUU+Hg98MnRzUMwjb7O25Xnz
 hwPo58lYVyWRL3wf6ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX5eZdnMNHfhHG
 Ud0MAi/nXuYAHTzr+SMODcokEjsgjmTibNslrQ5K9MggMBYbdwkJ0Ipz2nxnIjjhBTY564005rf
 wgK2Y4cVY6n+amytiFcqUeXjtvl77LA=
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

T24gVGh1LCAyMDI2LTExLTA1IGF0IDEyOjI0ICswMDAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBBZGQgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBob3cgdGhlIGFycmF5IG9mIGRybV9wdnJf
aGVhcCBpcyBmaWxsZWQgaW4gYW5kDQo+IHNldCBleHBlY3RhdGlvbnMgZm9yIHdoZW4gdXNlcnNw
YWNlIGFuZCBrZXJuZWwgcnVuIHdpdGggYSBtaXNtYXRjaGVkIFVBUEkNCj4gaGVhZGVyLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0
ZWMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0
ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLS0tDQo+ICBpbmNsdWRlL3VhcGkvZHJt
L3B2cl9kcm0uaCB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vcHZyX2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9wdnJf
ZHJtLmgNCj4gaW5kZXggY2NmNmMyMTEyNDY4Li5jZDg1YWMyNTdjZGIgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvdWFwaS9kcm0vcHZyX2RybS5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vcHZy
X2RybS5oDQo+IEBAIC0yNTgsOSArMjU4LDIyIEBAIHN0cnVjdCBkcm1fcHZyX2Rldl9xdWVyeV9l
bmhhbmNlbWVudHMgew0KPiAgICogZW51bSBkcm1fcHZyX2hlYXBfaWQgLSBBcnJheSBpbmRleCBm
b3IgaGVhcCBpbmZvIGRhdGEgcmV0dXJuZWQgYnkNCj4gICAqICVEUk1fUFZSX0RFVl9RVUVSWV9I
RUFQX0lORk9fR0VULg0KPiAgICoNCj4gLSAqIEZvciBjb21wYXRpYmlsaXR5IHJlYXNvbnMgYWxs
IGluZGljZXMgd2lsbCBiZSBwcmVzZW50IGluIHRoZSByZXR1cm5lZCBhcnJheSwNCj4gLSAqIGhv
d2V2ZXIgc29tZSBoZWFwcyBtYXkgbm90IGJlIHByZXNlbnQuIFRoZXNlIGFyZSBpbmRpY2F0ZWQg
d2hlcmUNCj4gLSAqICZzdHJ1Y3QgZHJtX3B2cl9oZWFwLnNpemUgaXMgc2V0IHRvIHplcm8uDQo+
ICsgKiBVc2Vyc3BhY2UgYW5kIHRoZSBrZXJuZWwgbWF5IGhhdmUgZGlmZmVyZW50IHZhbHVlcyBm
b3IgQERSTV9QVlJfSEVBUF9DT1VOVC4NCj4gKyAqIEluIHRoaXMgY2FzZToNCj4gKyAqDQo+ICsg
KiAgLSBJZiBLTUQoQERSTV9QVlJfSEVBUF9DT1VOVCkgPiBVTUQoQERSTV9QVlJfSEVBUF9DT1VO
VCksIHRoZW4gdXNlcnNwYWNlDQo+ICsgKiAgICBzaG91bGQgZWl0aGVyOg0KPiArICoNCj4gKyAq
ICAgIGEuIGV4cGxpY2l0bHkgcmVxdWVzdCBhIG51bWJlciBvZiBoZWFwcyBieSBzcGVjaWZ5aW5n
IGEgdmFsdWUgbGVzcyB0aGFuDQo+ICsgKiAgICAgICBvciBlcXVhbCB0byBVTUQoQERSTV9QVlJf
SEVBUF9DT1VOVCkgaGVhcHMsIGFuZCB0aGUga2VybmVsIG11c3QNCj4gKyAqICAgICAgIGlnbm9y
ZSBoZWFwcyB3aG9zZSBJRCBpcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8gdGhpcyB2YWx1ZSwg
b3INCj4gKyAqICAgIGIuIGlnbm9yZSBoZWFwIElEcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8g
VU1EKEBEUk1fUFZSX0hFQVBfQ09VTlQpIGJ5LA0KPiArICogICAgICAgZS5nLiBjYXBwaW5nIHRo
ZSB2YWx1ZSByZXR1cm5lZCBieSB0aGUga2VybmVsLg0KPiArICoNCj4gKyAqICAtIElmIEtNRChA
RFJNX1BWUl9IRUFQX0NPVU5UKSA8IFVNRChARFJNX1BWUl9IRUFQX0NPVU5UKSwgdGhlbiB0aGUg
bWF4aW11bQ0KPiArICogICAgbnVtYmVyIG9mIGhlYXBzIGlzIGNhcHBlZCBieSB0aGUga2VybmVs
IGF0IEtNRChARFJNX1BWUl9IRUFQX0NPVU5UKSBhbmQNCj4gKyAqICAgIHVzZXJzcGFjZSBtdXN0
IGlnbm9yZSBoZWFwcyB3aG9zZSBJRCBpcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8NCj4gKyAq
ICAgIEtNRChARFJNX1BWUl9IRUFQX0NPVU5UKS4NCj4gICAqLw0KPiAgZW51bSBkcm1fcHZyX2hl
YXBfaWQgew0KPiAgCS8qKiBARFJNX1BWUl9IRUFQX0dFTkVSQUw6IEdlbmVyYWwgcHVycG9zZSBo
ZWFwLiAqLw0KPiBAQCAtMjY5LDcgKzI4Miw3IEBAIGVudW0gZHJtX3B2cl9oZWFwX2lkIHsNCj4g
IAlEUk1fUFZSX0hFQVBfUERTX0NPREVfREFUQSwNCj4gIAkvKiogQERSTV9QVlJfSEVBUF9VU0Nf
Q09ERTogVVNDIGNvZGUgaGVhcC4gKi8NCj4gIAlEUk1fUFZSX0hFQVBfVVNDX0NPREUsDQo+IC0J
LyoqIEBEUk1fUFZSX0hFQVBfUkdOSERSOiBSZWdpb24gaGVhZGVyIGhlYXAuIE9ubHkgdXNlZCBp
ZiBHUFUgaGFzIEJSTjYzMTQyLiAqLw0KPiArCS8qKiBARFJNX1BWUl9IRUFQX1JHTkhEUjogUmVn
aW9uIGhlYWRlciBoZWFwIChvcHRpb25hbCkuIE9ubHkgdXNlZCBpZiBHUFUgaGFzIEJSTjYzMTQy
LiAqLw0KPiAgCURSTV9QVlJfSEVBUF9SR05IRFIsDQo+ICAJLyoqIEBEUk1fUFZSX0hFQVBfVklT
X1RFU1Q6IFZpc2liaWxpdHkgdGVzdCBoZWFwLiAqLw0KPiAgCURSTV9QVlJfSEVBUF9WSVNfVEVT
VCwNCj4gQEAgLTMxMCw5ICszMjMsMTMgQEAgc3RydWN0IGRybV9wdnJfaGVhcCB7DQo+ICAgKiBz
dHJ1Y3QgZHJtX3B2cl9kZXZfcXVlcnlfaGVhcF9pbmZvIC0gQ29udGFpbmVyIHVzZWQgdG8gZmV0
Y2ggaW5mb3JtYXRpb24NCj4gICAqIGFib3V0IGhlYXBzIHN1cHBvcnRlZCBieSB0aGUgZGV2aWNl
IGRyaXZlci4NCj4gICAqDQo+IC0gKiBQbGVhc2Ugbm90ZSBhbGwgZHJpdmVyLXN1cHBvcnRlZCBo
ZWFwcyB3aWxsIGJlIHJldHVybmVkIHVwIHRvICZoZWFwcy5jb3VudC4NCj4gLSAqIFNvbWUgaGVh
cHMgd2lsbCBub3QgYmUgcHJlc2VudCBpbiBhbGwgZGV2aWNlcywgd2hpY2ggd2lsbCBiZSBpbmRp
Y2F0ZWQgYnkNCj4gLSAqICZzdHJ1Y3QgZHJtX3B2cl9oZWFwLnNpemUgYmVpbmcgc2V0IHRvIHpl
cm8uDQo+ICsgKiBQbGVhc2Ugbm90ZSB0aGF0IGRyaXZlcnMgbWF5IG5vdCBuZWVkIGFsbCB0aGUg
aGVhcHMgdGhhdCBhcmUgcmV0dXJuZWQgdXAgdG8NCj4gKyAqICZoZWFwcy5jb3VudCBpbiAmaGVh
cHMuYXJyYXkuIFVubGlrZSBmb3IgcmVxdWlyZWQgaGVhcHMsIG9wdGlvbmFsIGhlYXBzIGFyZQ0K
PiArICogdXNlZCBvbiBzb21lIEdQVSBjb3JlcyBvbmx5LiBUaGUga2VybmVsIGluZGljYXRlcyB3
aGVuIG9wdGlvbmFsIGhlYXBzIGFyZSBub3QNCj4gKyAqIG5lZWRlZCBieSBzZXR0aW5nICZzdHJ1
Y3QgZHJtX3B2cl9oZWFwLnNpemUgdG8gemVyby4NCj4gKyAqDQo+ICsgKiBUaGUga2VybmVsIGNv
cGllcyBhbGwgcmVxdWVzdGVkIGhlYXBzIGludG8gJmhlYXBzLmFycmF5IG1hdGNoaW5nIHRoZSBv
cmRlcg0KPiArICogb2YgaGVhcCBpbmRpY2VzIGFzIHRoZXkgYXJlIGxpc3RlZCBpbiAmZW51bSBk
cm1fcHZyX2hlYXBfaWQuDQo+ICAgKg0KPiAgICogV2hlbiBmZXRjaGluZyB0aGlzIHR5cGUgJnN0
cnVjdCBkcm1fcHZyX2lvY3RsX2Rldl9xdWVyeV9hcmdzLnR5cGUgbXVzdCBiZSBzZXQNCj4gICAq
IHRvICVEUk1fUFZSX0RFVl9RVUVSWV9IRUFQX0lORk9fR0VULg0KPiANCj4gLS0tDQo+IGJhc2Ut
Y29tbWl0OiAzM2VkMjYyMzVkYjkzMTYyOTM1ZDE3MTliYzZmNTM4YzM4NGEyZmQ4DQo+IGNoYW5n
ZS1pZDogMjAyNjExMDUtZG9jdW1lbnQtZHJtX3B2cl9kZXZfcXVlcnlfaGVhcF9pbmZvX2dldC02
NjY0ZTk3OTMzNDANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBMdWlnaSBTYW50aXZl
dHRpIDxsdWlnaS5zYW50aXZldHRpQGltZ3RlYy5jb20+DQo+IA0KDQo=
