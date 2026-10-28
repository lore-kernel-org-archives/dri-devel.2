Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A8606A323
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=L75l5H3i;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=rwzlfi5y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35C310E04C;
	Wed, 28 Oct 2026 10:58:50 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0E510E04C;
 Wed, 28 Oct 2026 10:58:38 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S8Gr0W700942; Wed, 28 Oct 2026 10:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=EPIITtEsB84qefs9ap3atA24cUIV130IXt8gLuHe9Eg=; b=L75
 l5H3i5BTp4SOYOKrlCtdhksIp5XpP8Z6nrVrgc4PRW81WKpfHpG7XZZEFUm7vIl5
 PeSFFBlLHS6mDyPL+RUIZZHrk9pC+v+RkYckk55cfBgv2FWBLEOVMSLcpxobrhvB
 yRp1RDV4eGUmIaV90cCyWVk83Br7FtPijBUVkFOgdlEhA/d9QFlVO5ME8jbAJS4C
 k2vvtAHeugYuSl44uAV3tsb+/OCLBIXEbeJZnwKBL9MoxOD38TXbq28gzS+iJAhh
 M9dRYSi9BPF63o4w5mk4zk3IPFXuZ/gGIiNRFNFxdbJBLbpyrMmlar+AjWEjB39z
 L81NbRpDq8qoK08+Tew==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021111.outbound.protection.outlook.com [52.101.95.111])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hk4168d9n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 10:58:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkbhrxV/qd8V0oPDbM0f8eewtJT8IjJeJa6PIXFIZHoaSW0badtIvwNANmwyP1891HnT8+LVl3VbylZb9hiTfrSP5/Fbb9CICpqR1BmVw9O/W3Wm6zibKfCjmX2PXgfnkxVtA9fsI7rptLerzF5mliZG45B58vCUgNKeNJRKSL5DvVntBzZog/q4iPL5c3CUMqmp7YwO3H74i/ry6bjCOuZQAKOuaBRUL/aqTHfAwLASOtXPPzz1ympT+NUUXG+mWnVHkCxRpH13XTi7QrBqZ19CBtDoJgT4vhDAkE1Th/1DVSL+6edOxpJZdpGCc/fmTH1wbwb7TbNRTXBHpeQGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPIITtEsB84qefs9ap3atA24cUIV130IXt8gLuHe9Eg=;
 b=BY//oU0VGBHVMASL8qOnMHsdNU+1Q9M48nJJDDy4s4y2EjGbipu0FOfCkkAEuzXltnGFK0O+wT5dcg03tOFtz6WxHIXUGY1f9aNN7AMyIa3bAEUKcBiAIeP+HN0OQCIiL44m+E6t0/TXMUtbAUHLlwYzz/N1jw750DHHS83/kr30UviQ0w2brJRcdnUgLd68Rvf6zvey01lrBiNV0eqKHRq94x7FSP7J/J2OGjGT5S32THfT92hlHoZMVVfnprOADnvw6/+ev8AkNG9rCWZSSmGAOY+ula3KT+XyLQTG99p3aOuPJ3iwh6IS5oHl1kacVyxeQPhygULh3QHbpLnTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPIITtEsB84qefs9ap3atA24cUIV130IXt8gLuHe9Eg=;
 b=rwzlfi5y0N+O2FF8nIZxSUYwQVPg6IPK09TrJy9GYQHlvzjQxWUGWvw/QGq1hbKfxUbrXwE/XWuQAuDsr2ur6GbeyStOjSJTaL3WfoBt5shmrx084fzgrBqSsU9NxFE6v3hDfaXHPhRUALlxMW0SzA4bxZ0Pz4CGCLLPnPxLjdA=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOBP265MB9361.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:58:22 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 10:58:21 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "gye976@gmail.com" <gye976@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH] drm/imagination: Update sgt_offset kerneldoc in
 pvr_mmu_op_context
Thread-Topic: [PATCH] drm/imagination: Update sgt_offset kerneldoc in
 pvr_mmu_op_context
Thread-Index: AQHdZss/mfhXEqjUt0G+e7m0wpQazg==
Date: Wed, 28 Oct 2026 10:58:21 +0000
Message-ID: <53c69695bbd44deeb1422d4ac09bb3979998b837.camel@imgtec.com>
References: <20261015-pvr-mmu-sgt-offset-doc-v1-1-aab9ba54b5a4@gmail.com>
In-Reply-To: <20261015-pvr-mmu-sgt-offset-doc-v1-1-aab9ba54b5a4@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOBP265MB9361:EE_
x-ms-office365-filtering-correlation-id: 52fd2cf2-b7c5-473a-de5e-08df34e261cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|261021123027099003|261021121427099003|56012099006|261009223027099003|261022115727099003|10067099003|22082099003|261026121527099003|18002099003;
x-microsoft-antispam-message-info: RfkuNqBiDuCo9wmBVyLNCAhZz+BgYtoQVB24a9w6KbRUevXl+CvEoEOY5Ycm2hB3poRbsLZEf/82U8yN1x7HoEYIjs5PU19A4sIAgIxfNK483bwYKnT5iug57bvsB5KMKf/bt3QH7wQmj8ddmirp4zL3xVlcXk1Xq22XQBEj80iwFF3gQ0eidYWq8qqQ891VCj8SG1CXPdYq4mbmTMNCnOFA38FpVIUqQGyVshOOPG4161nWTtS+3XM0eCI0L1vC88oOyFMpTrA8mgVrEOYpFRoDCPP41DctrJgppzCPO08XyDcdF5+sIZ6EzyiHi2Wc3Lxu/UsdSEIVJeAHYXTb1gCURAEa1oAQG7YZE4LUogARD0crZyOk0LIMT5EfULdsfPhWYTyw3yrQRVNAWS4d8+N7r6xwORkaGXAhY961dueuQPc6CwLEHLvmOdBrhyyTxqD+iwKje5mJObcr0LEn1cxWjFtLsuy8lqi3CMhyv5rjH/0u5bzDcCUidWsvbIHNTmHGkOdVLDCaQY3XCOpb4wRBNV6/WHWErN59wK0L6qnJ8NN4SkMv3JA9bVfYJCJd6PW6DgAcdTJSO4OYkjPg3GxjO2Eusfh19D32DGXkgqFKhP5cg9G8b1JDiERljfQIwXyGgfES3NreNGKn8ZaH6qWnjuxmJ+IU7msOp3z75i8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261022115727099003)(10067099003)(22082099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVUZnBvWnhGMWdMWG9mUS9YVG1HS1pKL2xyNDBuYkJWQS9uZFM4MVhLaDZX?=
 =?utf-8?B?MUdpUHpjeEpQdlZoK1puczBIbml5WU5WTHgrdFJ6aTZFUG5aM1JZY3cveHFw?=
 =?utf-8?B?Smd6b2tpS3NkQTJXOUdRUHduczl0LysrbXU1QnpOVGVDM1p3Y2FEZGQzY0Mw?=
 =?utf-8?B?SUhXMXYyenV1TkpZRndPQm5KanRBOWFCdHNlaDFobHNzNmV5ODg0OE45dHNm?=
 =?utf-8?B?ak5mR1pHeWdzZXBqMVhhQjE5Snl4YkhhNkk4MFQyOXpUWCtOb3hIZkFzR1hy?=
 =?utf-8?B?ZitZR1RRN1AvQlFYZWJzeWltcHNBdXo0N0ZrNmtUWmN0ZXk3aFdoN09JSExN?=
 =?utf-8?B?d0I0OTZseWdrNGozOTR1WWdHRnBNS1F4M2l3SXlNN0QrL0R4RzlZZndTMXJp?=
 =?utf-8?B?VmdGVFI4VXZPSkUyc3lYcVVmUTNuaDEybUxYS050ZkFlOXEzSFpWTmMzcWg3?=
 =?utf-8?B?Q3l1RXNCSnN6RmNqdnVFTWE4SVFlYTgyRCs5MjJGQktMeWNXN3dvRDR5ZU9o?=
 =?utf-8?B?VzUwNU5jSU9hdDdYWURRcUEzdzF3NnpMZ3doMzZsL1Z6MmtsMSs1c1dBQ3g1?=
 =?utf-8?B?bldSOTN5U00wdVFhd0M1QzZGYXR4eGJSYUFMemRUZmpDejZtWlFOYysvYVVk?=
 =?utf-8?B?dlNCTmcrTGhxVTV1UzQ2RnowWDRqZnp6N0FOc0tIUHdRSWgzQlViZ1IwZHgx?=
 =?utf-8?B?ZFVtNXl5NGordDU1RmMvVzNDRHJ6MG1tcWJybGV0NUtUMENDTWwvbDlvNEkz?=
 =?utf-8?B?S2FkMkhwblpWRDY1TTc1aHhoc2ZWTFY2UmNyRk9ZdGpudW5UdTVFaW9wQVk2?=
 =?utf-8?B?WkR0Tk1mb0dDRkhPYVp2RVBRTzNCdXNFQmZrSGFYU2dlNGt5TmY3cndjR3E5?=
 =?utf-8?B?WGo1R2t5TVBQNW1YY3FTUC8vQ2duNEY1MEIyMCs2Ni9FZnNWRkhRc2VCaW03?=
 =?utf-8?B?OGpzT0JZako3anJVZDBtdjJLbkJyNFRPTVVwQ0VtTyt1NFk0Vk1HRjlkWlZj?=
 =?utf-8?B?U2t2WC9tUi9DMzBrdFZWVTFVMHFmbnc3KzVmaGVvWFg0MlBnMG5TS0NoQjN5?=
 =?utf-8?B?bVo1RjgycE9mRkFuenA4cDFRWUdqcEg4Y0lOamFlYlVGNHBTUUZkRUYzeGJD?=
 =?utf-8?B?NmpxbmxaMVQ3eEZlS1NsTWpyNHNqTDNxQmEvOWJnOWtzaHpReDhvaXhPRGND?=
 =?utf-8?B?a3RILzd3OG8zbUxmbjZJTDFuSlFTRWRqTHJMK1pUM1ordzdVQnBML2YwK2Jz?=
 =?utf-8?B?S2x0Y1ZXU2lIUXArRitwYmNnN042VDBxZ1hpVndvOEdESXY5aGN2R0U0Z3RF?=
 =?utf-8?B?TUd0TFhkbXUzbURVOVRVOFlveUt6NGxhWUFZa3p6bFllZHR0SGhGQTJ0U2Fi?=
 =?utf-8?B?Tmp6S1FSd0VuMUNCN2xRQkJBS3VxZ2pjQXZiRmt1YUF0R0F2OWRsbU5uNExi?=
 =?utf-8?B?UGRFcm1vUXAydThPU21lRThkZW1KeVhWbEZIM3JwNTc4UUlXZzYxVlJ0R1hQ?=
 =?utf-8?B?VFduK2grZ0xoWHFkZlFiVVk2c0FLQm14blMySDMwWk14RXhwQU5qYndCbnFC?=
 =?utf-8?B?dEJkekdqd0REcE1wV0JBK2N6RnNvV0p6cmtUUW1BcExyZm1YRk1RTXZRSldy?=
 =?utf-8?B?UXlDWVcrcEs1OVhYejdVVktNV0JXWkRVZ0Rnd0kvd2ViL3ZkWXU5eVc5dDds?=
 =?utf-8?B?UjA4SHJrVG9UMDY0ZkIzZ0tFVlJaUDZ5OElBMmVuTWE5ckRCUVNBczVaeGww?=
 =?utf-8?B?UjhkeUx6bjJpUy96ZHdQUnE4bEd6U0FEMVYxWjlVSktHOHBQeE5jM2kwWWEy?=
 =?utf-8?B?aDJjc2V3bThDZnRDazlyVmdWT1NOeTU3V01TOWhnSGFVY1NQdmQvWlJvT3pz?=
 =?utf-8?B?TGJ6VkxtVnowVDV2emJFOGk2U3N0Z0s3ZkVlb052N1ludWVjT3hzdEFjVzlE?=
 =?utf-8?B?SjM4alEwT1g2ZUp5RDcxczZIUzI0dXJMNE9BendaaWVyZ01Ja2diMC9vbGdB?=
 =?utf-8?B?QTQxdjJuSlI2WGhlVldKekpuZEJqckZkYWkzanZFNWhiUWVqYkpTWm9MU3R2?=
 =?utf-8?B?L1FFVW5NSDF6N2QyOTR2QzBZZ0M0a2ZoZnpaOFprZk5Ubm0vRzg4QkY5UlBh?=
 =?utf-8?B?MjZGNEJrQlZBTnc2Skl1MkxsNStPeFR0dUh2bWFLSVlqajE3a1RjNkVOU1l1?=
 =?utf-8?B?SksxbVNFOFdUcG1hR3pyd0Z0VVpEY28veElVL0NGT0RUVDlwTWFuV3YyQ1RL?=
 =?utf-8?B?VlBKM09uYkxpZUpRWTVhZEx0QTZkRnQ2b0NJS01HTm5GOEpnS2R2dXZQOVlY?=
 =?utf-8?B?OXBqUXZHVVJRRjIvWGhoZ09BY3RFWGZsMFIwbndSRDJWbHAvNUF4RDRHSElE?=
 =?utf-8?Q?JRfSQ+42DWhLjuVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AF8EC3B1A2A5149B3471B52A022FEB2@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b1jNxxLfPnVjdLsfjihdcGeY/SmmKvfhJ3zKGlJpGUcut/UgpdVAdM3NZ4044aHkWc0ADfXw8A+vy4gX4fUQ4ASPq0g5Ns8uj9faUY1Fyzls96avGDVcpgRPkBj0ZWrMI6xy6oFWFKDnOoGnvdSOT9jYRwQhL5Ay0JTg5KCmB2M6gNZQpXyIOoKBpdPdxHAgy7X5HgrvEF6Cy0tnAORu0yDQT5Rz/KTfdfUAt6v48TCPnMtS2uuWErh9k773LJ5lsZwxmnYNHU13X76DIcG5B66LrIGgj8nQDjTgudYwmE2RQwo00wJJwMhJSwADPytQ1rl+bSevGG/KzS+QzvVS+w==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fd2cf2-b7c5-473a-de5e-08df34e261cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 10:58:21.7265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxqVY1zo4qmEPa+8rM53cp17qUPpmhsN4UFFWXYofvMeW/ktjDNs658PfHqrWgb5oAaT0x86QP7Ufe+jjxggwOwVO32JVZlZ4Xtg12gbae8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9361
X-Proofpoint-GUID: t9bsjIjAkVlwIXeRH39eQ2Ts_24HQQlr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MyBTYWx0ZWRfX7S/4OMbgXDpL
 dZzOdsDMspgS3H6RjXYmwDpSyUX7BW4mlQK/2j72GMgY1yYswfzgJ13NCea+x4E/FQIB50cMAI5
 k113F4aVVkvvARA4n7IrRPaVRIlI+950xJCbYJ+6ZHgkNeaNlmUAkqaCsSsS/10vZtiEGpozsSn
 l0YVSN6GnBAKRbOxAkxlyB94M61YzakBqACwC5/1uXvrdKNUcFM2VYiNqx2Eyc1CheRPhhPVXsj
 vUjlw+yghBWzfXJHxVouuUdCItSG6q3ptAZ+y/7exZgY+c2FP727bvgVvLHHxdAP71afre0hn+V
 MLAmKrWwiylnYunZA1WFRteGCRJp+vaIChUge0tTcdUJWYgX5WxquTWgfgYQp7eraOKXiP27cMu
 9zJG9CP9vBrXG/ZrIam3MNGVwwShBpR/UW6LBu5cdT3GSwLntPiSlS/Jvqg+8heMtcEiHQpAJEy
 S3f8Ny8Wt73hbG2SbAQ==
X-Authority-Analysis: v=2.4 cv=apQnmiZV c=1 sm=1 tr=0 ts=6ae1d550 cx=c_pps
 a=8zspI6yfgVy7Cbfd8RVNOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=pGLkceISAAAA:8 a=aofUYkmP4FFBHTV_i6cA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: t9bsjIjAkVlwIXeRH39eQ2Ts_24HQQlr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MyBTYWx0ZWRfX1xIOAQVdReVY
 FiIHGuskhXpF2K4ou9gi2awdKMEByXf/rXNq4BMnEasRht9YfC8IGu9gpgW76YuaM5WLGp3UBF1
 BCBG30Q30IhllWkvPJpjIPGCoVtfpsU=
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEyOjQ4ICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
PiBVcGRhdGUgdGhlIEBzZ3Rfb2Zmc2V0IHN0cnVjdCBtZW1iZXIgZGVzY3JpcHRpb24gbWlzc2Vk
IGJ5DQo+IGNvbW1pdCA3ODlmMjkwYjJlODEgKCJkcm0vaW1hZ2luYXRpb246IFNpemUgcGFnZSB0
YWJsZSBwcmVhbGxvY2F0aW9uIGJ5DQo+IGRldmljZSBhZGRyZXNzIikuDQo+IA0KPiBTdWdnZXN0
ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCj4gTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci82NGI5MTVmZTNjNzk0NTY3YTA0Yzk1NWZhODkxODQy
MDRlM2I5NTUyLmNhbWVsQGltZ3RlYy5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IEd5ZXlvdW5nIEJh
ZWsgPGd5ZTk3NkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVz
c2lvLmJlbGxlQGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jIGIvZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9tbXUuYw0KPiBpbmRleCAzY2FjNDgyZTEwMzQuLjZiNDNlYTRjN2Y2MyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+IEBAIC0xNDEyLDcg
KzE0MTIsNyBAQCBzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0IHsNCj4gIAkJICovDQo+ICAJCXN0
cnVjdCBzZ190YWJsZSAqc2d0Ow0KPiAgDQo+IC0JCS8qKiBAc2d0X29mZnNldDogU3RhcnQgYWRk
cmVzcyBvZiB0aGUgZGV2aWNlLXZpcnR1YWwgbWFwcGluZy4gKi8NCj4gKwkJLyoqIEBzZ3Rfb2Zm
c2V0OiBPZmZzZXQgaW50byBAc2d0IG9mIHRoZSBzdGFydCBvZiB0aGUgbWFwcGluZy4gKi8NCj4g
IAkJdTY0IHNndF9vZmZzZXQ7DQo+ICANCj4gIAkJLyoqDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21t
aXQ6IDQ4OWE4NTM5Y2E2ZjM0NzEwMmMxMzM0YzJmMDgxOThhYmFjYzg2YzgNCj4gY2hhbmdlLWlk
OiAyMDI2MTAxNS1wdnItbW11LXNndC1vZmZzZXQtZG9jLTE4MGJhNjQwZTA3Ng0KPiANCj4gQmVz
dCByZWdhcmRzLA0KDQo=
