Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B63606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=KBhnicg8;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=a32C/BTe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5172A10E3E7;
	Mon, 16 Nov 2026 12:56:48 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D9610EE94;
 Mon, 16 Nov 2026 12:56:36 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AGBN73I3976869; Mon, 16 Nov 2026 12:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=r43chFs/Tm7d/IwgTFBXzaR1Ak9Dw86NeiksAyli/+M=; b=KBh
 nicg88NFhj+xQkgFvEubBN4kZIhD7l2D1PN2EMPq9RSmdkHQlZLt4th6zOKoX9K6
 Kj3iI8enmHaUTAKLLyfGJ54VKNs+NRDiRRBxlbSvX7nT34lENkleXsmfW8+nqey1
 MqrIbJzT+hlJfakmgM3/yGiL3ZxtPNtcNpuNBAx6fhCiiNfeWeZg+FvYdCc9bDyy
 iSYit2v3OOkzEtq4b45sGMsVI4u50CV4tHzNCYaj2k11K5zrbY7kV4TLFosMj3ON
 rejqdHaqWBL66mCOQQi3kNs5CDZ8PGNqa6kbqRiZYQZATrbNMQm/G5ewn/ArbwtK
 luHgzGZOzomPmv7b85Q==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020111.outbound.protection.outlook.com [52.101.196.111])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j00w1g2ae-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Mon, 16 Nov 2026 12:56:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNBdfuNgRqHCzJWJIv7BDrwv0vEHq8x2PGy7gZcZRlp66kmCtZujxLdjBEOmEFhvqODzWbkm/dsAqkG2IONumTgKjPBjqwMqfoUnhrLJMnsqrGkbEBwrLIQdZZetd9n3Aa5EEu4qqQ3NQZOm4qsSMU8AeFyhph2bNS4/nh9a3aiT4iSLuwxFRUkXQxerwqjqV5PlczcmQyfWhM7hjV9/AV4oTub49tdFxVHRvCppwhm1cpiwsrCFCmmomT64T2qyTM4ywwqlA0mZJEDDYmqMMmQwJkt9zDXsf/3udhTKeR+RhrXZs364xkOsRBaHyVp9NUwp+fumc3HN4W3NXVsChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r43chFs/Tm7d/IwgTFBXzaR1Ak9Dw86NeiksAyli/+M=;
 b=M3bBDJKJt4jFdMDoiFBOBOEGW0qeCdd1+A8LccQmt1fA1yZ5RSmPBKWwXX8YMe29WRbmBt8pSkByy3ii2XgrODGfAj63ux6W80ftIXZsLuWvbbiKl2wsYDQs0jqeJyuuqTX+L7JKfZsZDLONQozU+n8MXWj/g9q6pOYCc5tvjGgzz5jrrUaCc9oDBGi8ne1dpnR4sykdqbzLP3V6MWSRXBT8dN2r95KNDkv6T5W9zmBsxOSKFGXiLT1gpnqDMGOcdoJsneunTdRBBefHryQ1Yh86H4vPrgQoYOwhnsBq4jw9A/Z2E/dAXHK6a4Jb+8CaAEWpLpSn+pRdOC6ZRPLsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r43chFs/Tm7d/IwgTFBXzaR1Ak9Dw86NeiksAyli/+M=;
 b=a32C/BTeUQGwmB6mmadx+8Ke6ehBEgDKOQ/UrqPBLmnl6XgNF1FdjOATjZSO6cLjgWealk27r2qhU4IJr80g5mK2/PsjGJRII+yPFIKTeeufbsHhSNcTMeUXRpdO86wmWllAZqkB2TpWc2VcaXrqm2G5Wo1iiso4flfgFL7Kcgc=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CWLP265MB6272.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:56:24 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:56:24 +0000
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
Subject: Re: [PATCH v2 0/2] drm/imagination: improve UAPI heap and static
 areas query ioctls
Thread-Topic: [PATCH v2 0/2] drm/imagination: improve UAPI heap and static
 areas query ioctls
Thread-Index: AQHdcIn0UPg+3VkKmkOnpYcf5QGs1Lcwsq4A
Date: Mon, 16 Nov 2026 12:56:24 +0000
Message-ID: <d912450f4bd5aac9577851e0173d66d37246c089.camel@imgtec.com>
References: <20261109-ioctl-query-count-stride-fixes-v2-0-228ea0e28dc3@imgtec.com>
In-Reply-To: <20261109-ioctl-query-count-stride-fixes-v2-0-228ea0e28dc3@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CWLP265MB6272:EE_
x-ms-office365-filtering-correlation-id: 4c4f44db-bb84-4d04-dc77-08df43e1051f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|56012099006|261026140227099003|261028144727099003|261022115727099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: iKDDDo6wfiS6TAtNp0MGqzB+U5GZMQ2mB4T9yItQs8Yq+hmaarTZHqT+mnje+7wG5CFrC85YGYNQNrKo42Rhk0SJ0DPLdeeG3VnqEGvxvboBM36If78SPD7UNfJ5ZsfsQApsgTSqnkl2Cf5JIoRCFRVjOUcs6/sor9jK9VC0cyvDuTKL9K6GW3XcgKf/F5QtO8NRqNK7arK3ODNRuM8khk/JkLiAM+MujEXPTK/5vzAdEk/2MYFHQTQIA0ZxYKyAP9CR9PdF4oRdCXAW+wxVK9GjsoEtJswoIS8eFiRuxEVEnaunahE6E8AdadDoViUQSmtLyJ0S6XZ3bsQIVtBndcpUabrmDZHsytdWWZex0JnkDJdXO3SlVXfqyQM7kGG2hKMJERgiyOuzCX+VDA8IciWFWwZ0N3aZiZO50vfwS87nlkWTjPy2OYBz6goJ29bi4w1Fpkfwx2ueaN5s+CKzGF3jLNaA3kFGh+snEYDSFCYvvRRgAPVv5Gy0Wmivm/0cWpj6ROqC9xRVroxQTWc145iOFcRbjC0774iIFOIyYfAs7mociI7pQQ4qjRhBAoaSZpb+IjhYYoyZDuGw74Uzd2LOu8J8tywSwKLvYMtdX4sfuwRFWK4ElSbENzSb3t9ulcP1bC9A2OQUnr365sTgAtYE9j+YGoyg9HXTj0YLrVc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022115727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUhITkQ4SHVPcXBUZVY5aWRxMVZnakZ0RGJmMTJLamhGTTJSWTVjZ2prdFV2?=
 =?utf-8?B?WnRGYkcwRFlyMW9PQ3lzaUpBMmowMzFCc0prb3dhbEcwV1BYNko5aHkyeVNQ?=
 =?utf-8?B?ZkkvaEM2dTVFeHJxa1QraGhwM2FFZDdLOHFab2ZadWc3clh3QllMZG5MSmNJ?=
 =?utf-8?B?N0ZTNjdKekNzL3EzWGRyWHZWWlVsWXA4MmNaUnBCNDRUbDdJUFQzRk9yRDR0?=
 =?utf-8?B?OGgrc3BmdWJ3MmkyRTNQMk9CTm05LzZaWHo5QWpSQ3M3NUFmU3hvVUNoZEx3?=
 =?utf-8?B?S29wME4ydjBoVGRNN0lKbE9iYlV1T3pHZ1pYSE1VejlhZmZrMDZjRWtRL016?=
 =?utf-8?B?Yjlsb2M3ZXVOWVd2TzF5eFVoSk9RUlFjUmZTMTREWWgzY1IzU3ZlaHNhY3JC?=
 =?utf-8?B?eHMrTmFxNjVJeG5SeGQ1VzMzYWdtV0ZrK3B5NC9LNWludmtBUDJUeVd3RXRq?=
 =?utf-8?B?bGJOUU1BWGtjeGw0Y01YN2YyRTJ0ZnNnVk9UMm0zK1FKRDlneWIxZ0tXUFc3?=
 =?utf-8?B?UVVydDEyYkJqaFYvNzBZMFFrcGU4VVAxZHVvQ3k1WXQ3S3I2NmNoekx1cHVo?=
 =?utf-8?B?SUprR3liVUI5ZjVCUnFlYllZMmVmTDdFYVJIUHdHNEx0eFM3M09OU2FEbUI1?=
 =?utf-8?B?OGM2OEM0ZnRuMjVxbk9LY0JRd3psenNZME1jb3RUWEhWcjRRQzBYZGN0dWpj?=
 =?utf-8?B?bWZHZmRsUWxTYmw1cXZqZXduRjlUQTZHK1hMTWo3MFROd01nYjN2cmZDWEZH?=
 =?utf-8?B?clRBQWFxRmE0VXFBU3BJSWEwcitrZ0JNN2NLcDhMVHZqWDExem44R3hKOU1v?=
 =?utf-8?B?ZmxSUUowT1JKNTU4amJOc08vRU5YbU9VN3NyTTRROFZ6M3EyTmxoTExnaEor?=
 =?utf-8?B?K2Q3VCtBeFllTkpSWHVHa0t5Wm9UT04zZ3Q5K2xseXNGSmFDcytGREkwdW9C?=
 =?utf-8?B?T2llUzExOHN2N2sxcSszbjJCQmJ1TUZrZi84MHBtZGVTVG1WYW1DVXJINy9P?=
 =?utf-8?B?dE9NUjBRa1VLa0pEdHF3dHdhcGRsT2hGeDhnaTRIZldHTWRGYWRYYWlkZWp6?=
 =?utf-8?B?d3k4QTBpTEpxekJIRWN5WHZNS2FIWlh6QU9lV0VRWWVxb1pReDF5OHM0Z0Ey?=
 =?utf-8?B?Uml3T1ZIcGRZT3VQY1k1STUzTS9Jb2lLZmF4K216eisyd21lak1rVHhsUkxk?=
 =?utf-8?B?aFB4Z2xSSmVOSVZnWk9BVnIyeTJqMkQ0K0lGZExJUUw5VTZxTkgxMVRYeWNR?=
 =?utf-8?B?cUVFSk5mbUFiajYyUmxJazFVMzFxU0xJU25TYUwyaUlGOGVOVGFYWHJEbVV1?=
 =?utf-8?B?bGFHRWNmTGM0S1VQTGRDR1ZoUHVzVHcwMDBRUHN4NTRwMzdLMlF3RUUvVi8x?=
 =?utf-8?B?YTZJSklDemh6UklVZFVHTTdod2xWcnJMZDlWSUFPSjFuc3MxbS9EVW40OCsv?=
 =?utf-8?B?SEhlK0FRQnV3VjZlanVzOEdsNlNnd3ZOaGg5Y3ZjazczS0srak1yd2NJVEsy?=
 =?utf-8?B?RHlyNTFsc1J3c1dhY1J3bE5kVjJhRzJUZlhjYzRnc3hOWWlxZFRYZXNDWGlx?=
 =?utf-8?B?QlFyMFRZazgxbktpekYyQ053UzV5R3MrbENpWHdGV1NKTytrcldoTUc4Z3g4?=
 =?utf-8?B?SHJmenRPbTUzMlltS3JVUnlOTTU4Y0pUci9lNDJPeUpBSkg4bGtPQVJCWnN0?=
 =?utf-8?B?bDdqNU0wa2tjenBVUDVyRTBQUXFGZHhmK2hGZEtick8zSUduL1g4aUUySWxz?=
 =?utf-8?B?WjdxbzlVWU5HOUxOMlQyWksyR2RHYXBETGxsSE9mVFJITUl4VmpQT1ZKMUlO?=
 =?utf-8?B?RnAreEQraDBMRXRoaDlKc2dhMzFLeHZGUWhLZ3NiTWxwUG5EclBVWWlSaVd1?=
 =?utf-8?B?YlJKMTUxYmV4M3YrRjdCbFJIRFNTUk8zL3dKU2Q2c3pVSXlRcTNERC9jN1Yr?=
 =?utf-8?B?SlgwRU1JNkxxR1pwR1FWSk84YmI3Q3FucHNPN3UyNytuV2RaS2NpYmJoemVN?=
 =?utf-8?B?N3REK21sWENwTXNKNlZQVlRzZndVekh5Qml1cWVPRE0zWEZzTXppTWhldCs5?=
 =?utf-8?B?dk50aTlEdHYwcnZ5cTlEK3VqclUrOFdBZmdqeGo1VFJ5eURDQ04rK1E0d2ZU?=
 =?utf-8?B?QVQ3a0wxZFhqLy9HZDZHUy90Q1o0ZWpEQnR6d2V2NVZTbUUwMkc4N2ZWbk5B?=
 =?utf-8?B?QmhuR1dqdmsvcWxhMkF6OXZaOFRBamMyWWwvSVBjKy9GTnB0bUZBa2d2NlJs?=
 =?utf-8?B?YXNkZFZJQTRrcFRhM0w3b2YxWE5BQXR6Rkx3MmoybjZWV1VPWGVBK3VWb0N0?=
 =?utf-8?B?ZjJLbFNWNVNmSFh0OXhLWnNFWDhydk1ZcS8weG4ycEJaU2NxZHFOYzZmRWJE?=
 =?utf-8?Q?GhBxQJDYskGcQGTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD97AC41EF3D5E44B8A88C51CF621B8E@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oo8HXFJ12aWQ/bLLDYzAC3V2Smu+5zJpjgn+/VtqDw65TRUmwZ8etm/PO57Pbi7UUYVsQjWvsYthSR0wLlWfsVsxbF8Eueh7tASTHAGD6JqEzbyt3W7isu/dk48l8hfCSk03WrucMLm2sCdrzgnc03hbZN6GFoAdJFt7xxLedMQuu6Gn44VXL38kDx4wcpmHUsvJtSOIOrHMSETe1CWF3kB2V6s0RbRyQA8O1wD0B/uUWqQlzMToqsOocHdRKel2MPhjnVts63LM51wR0UDHkAdoOUqduWLPOuIznzrnHtvzHP23kHrmXGo3vX7UyvsqLuDKh7K8IhdqpvRipLFLMQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4f44db-bb84-4d04-dc77-08df43e1051f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 12:56:24.1669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+XHFMAUiZ3hW5lmQUI1gqxW4uoZHdagFtanmj+6npeFLxI9sATxcAj8+Glh/GgiopcC1omxV883wISaVUe8kkt+peZVTBhe9evd6YbWu70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6272
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX8lEX4ud3G68A
 Scuw6uZwQkFL3I+M2G+Xqoc/B8RGanlnLo308XBrEUFWzs8oh3hCpG8WU1bIl5ODixINjUwFOge
 QrGYUXX+aPi+5k8YXAaDN/SJ84fOQC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX2rf1NPZ3/60X
 CV9ZhbFXGdbvovmV46cd8NQW7QL4Ekz+W6DjMG2AfnxAhxH8S+ulhXO3GKowBCcJBLKgj3DaZ2b
 SfS1Ub+3b510th6afUzMRF99PkbPSjfHkdqOXu1/eNpVjEtxIHG+an0Q+9c+d6wUwlu7wH2ij2i
 PBVrYo5iv5hGkx+a+Vdlv7+w9Qqu+Y6yJyDRiN4u/KV0te4ShG5XODezrnrb6TSasvbCyOA8UAL
 UAqqoIp6lXmhYV2N4MRs2y3iPRz7XTWNqaFQuCzXhBpe3arqK2WSsaHNxSqh0Pt0rpAkf4LPTY7
 uS5FnE6ErHcck3XYmJpb/OnIK8dOgjnBL+RDXJAHaI8OcVTIB2mtvp5fF7QWN1UHV1yprDKM9r5
 dDuLybsTR0RYpGDCJc5HwCaKhtekpMhCiYeIQlkbksrbZoAmVZRaC2mM/ApkQesEbFGe37fHNF9
 dZcHfjyIU14BS67kGzw==
X-Authority-Analysis: v=2.4 cv=Yoqa1IYX c=1 sm=1 tr=0 ts=6afafd7b cx=c_pps
 a=x08jvADxgcX9NU8ZR8w9tw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=e5mUnYsNAAAA:8
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=ish7FPFtLS3Ct7oorlEA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: UgJ8YFRrJz5JuUyoyAptr3PpKPHNVoSf
X-Proofpoint-GUID: UgJ8YFRrJz5JuUyoyAptr3PpKPHNVoSf
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

T24gTW9uLCAyMDI2LTExLTA5IGF0IDIwOjM1ICswMDAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBUaGlzIHNlcmllcyBpcyBhYm91dCBiZXR0ZXIgcHJvdGVjdGluZyB1c2Vyc3BhY2Ugd2hl
biBlaXRoZXIgb25lIG9mIHRoZQ0KPiBoZWFwIG9yIHRoZSBzdGF0aWMgZGF0YSBhcmVhcyBxdWVy
eSBJT0NUTCBpcyBtYWRlIGFzIHdlIGdvIGZvcndhcmQgYW5kDQo+IGV4dGVuZCB0aGUgVUFQSSBp
bnRyb2R1Y2luZyBuZXcgaGVhcHMgb3IgbmV3IGZpZWxkcyB0byB0aGVpciByZWxhdGVkDQo+IGRh
dGEgdHlwZXMuDQo+IA0KPiBQbGVhc2UgcmVmZXIgdG8gZWFjaCBwYXRjaCBjb21taXQgbWVzc2Fn
ZSB3aGljaCBkZXNjcmliZXMgaW4gc29tZSBkZXRhaWwNCj4gdGhlIG5hdHVyZSBvZiB0aGUgaXNz
dWUgYW5kIHRoZSBzb2x1dGlvbiBmb3IgaXQuDQo+IA0KPiBJbiBnZW5lcmFsIHRlcm1zIHRoaXMg
c2VyaWVzIG1ha2VzIHRoZSBVQVBJIG1vcmUgZmxleGlibGUsIGludHJvZHVjaW5nIGENCj4gZGlz
dGluY3Rpb24gYmV0d2VlbiBhIGxlZ2FjeSAob3IgbWluaW11bSkgYW5kIGEgY3VycmVudCAob3Ig
bWF4aW11bSkgdmFsdWUNCj4gZm9yIGJvdGggdGhlIHN0cmlkZSBhbmQgdGhlIGNvdW50IHRoYXQg
aXMgcmV0dXJuZWQgdG8gdXNlcnNwYWNlLg0KPiANCj4gV2l0aCB0aGUgbmV3IHBhdHRlcm4gaW4g
cGxhY2UsIGFuIG9sZGVyWypdIHZlcnNpb24gb2YgdXNlcnNwYWNlIGRlZmF1bHRzDQo+IHRvIHJl
cXVlc3RpbmcgYW5kIHRvIG9idGFpbmluZyB0aGUgbGVnYWN5IChvciBtaW5pbXVtKSB2YWx1ZSBv
ZiBib3RoIHN0cmlkZQ0KPiBhbmQgY291bnQgYW5kIHRoaXMgbWFrZXMgc2FmZSB0byB1cGRhdGUg
dGhlaXIgbWF4aW11bSB2YWx1ZSBnb2luZyBmb3J3YXJkLg0KPiANCj4gWypdIGJlZm9yZSBodHRw
czovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vbWVyZ2VfcmVxdWVzdHMvNDQ0
NTYNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1aWdpIFNhbnRpdmV0dGkgPGx1aWdpLnNhbnRpdmV0
dGlAaW1ndGVjLmNvbT4NCg0KRm9yIHRoZSBzZXJpZXMsDQoNClJldmlld2VkLWJ5OiBBbGVzc2lv
IEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkFsZXNzaW8NCg0K
PiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZWJhc2Ugb24gZHJtLW1pc2MtbmV4dCBvbmx5
DQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYxMTA0LWlvY3Rs
LXF1ZXJ5LWNvdW50LXN0cmlkZS1maXhlcy12MS0wLTJiZjg2ZGQ3Y2YyOUBpbWd0ZWMuY29tDQo+
IA0KPiAtLS0NCj4gTHVpZ2kgU2FudGl2ZXR0aSAoMik6DQo+ICAgICAgIGRybS9pbWFnaW5hdGlv
bjogY2xhbXAgc3RyaWRlIG9mIGhlYXBzIGFuZCBzdGF0aWMgYXJlYXMgZm9yIGxlZ2FjeSBVTQ0K
PiAgICAgICBkcm0vaW1hZ2luYXRpb246IGNsYW1wIGNvdW50IG9mIGhlYXBzIGFuZCBzdGF0aWMg
YXJlYXMgZm9yIGxlZ2FjeSBVTQ0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfZHJ2LmggfCAzMyArKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0v
aW1hZ2luYXRpb24vcHZyX3ZtLmMgIHwgMzIgKysrKysrKysrKysrKysrKysrLS0tDQo+ICBpbmNs
dWRlL3VhcGkvZHJtL3B2cl9kcm0uaCAgICAgICAgICAgIHwgNTMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTA4IGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDhkZWFhZGU0YTVhNGZmNjM1
ZGY5MWUyNDZlNDIxMzlhYjJiMzNmNmQNCj4gY2hhbmdlLWlkOiAyMDI2MTEwNC1pb2N0bC1xdWVy
eS1jb3VudC1zdHJpZGUtZml4ZXMtNDNiNGRmMmMyZmM4DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tICANCj4gTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0ZWMuY29tPg0K
PiANCg0K
