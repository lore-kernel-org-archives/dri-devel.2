Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD38CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D057112234;
	Thu, 15 Oct 2026 09:08:24 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C4A112234;
 Thu, 15 Oct 2026 09:08:13 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6gsHu3644337; Thu, 15 Oct 2026 10:07:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=7yP3/Nak+u+59rxDuDab5ZH0FoHa46InfPM75353J2Q=; b=j7+
 9FgQwGQKneHZQxjtlUgKpYWJOSUtFs4Qg+5eVr/tagt9aJR56LPMa1aN9Cw+YuYj
 B/HgPBNDYMdeYlB+vUtFk2YJ5OF20bYSFi9/toTtiudEgKOJgLpcu5Ov5zSg2Kv1
 kWbUop1dCPH18ieyz4as+nuYvonDGHWmMIBXVFyVCBJQ5d7i7zh2NOr+t+XyWkee
 3WDjUOnifgCByGPyGkjRQDuH4rhHhvCQbdp1FZ90HNKfxBj2vSxLP37LpQWVjLSV
 Yo9NCIgvq1EzeAoMAoOgfWwwXM+NKszZ3ZAsOt4cYhPuQyotXGZsu7p79+Hg9wSn
 T7ZFYUSF4IdehSnsDjg==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022117.outbound.protection.outlook.com [52.101.96.117])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h7det4c3j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 10:07:58 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0BUuKtQ3dvl3s7wzOhbc+eDwqXZiADQyiaOhF0ffLXjJgLj3ujPXeYvAuwJrGe9ycVS0tTIN/In69UfuD5BcWjnzWYobZ7IhEWsjH04jqAB6sj5jQYxZTEk3E6HR87CWAZfnR+TtMOoqyHMaIe7vBINkHaosX/o9ibC0HCwSbcUSuLEuPHnaH6q5YNxOG7LtDp0qIY67DeR8HjVkRvXRbhTrGDLVZYajtOryi81gCWYT4rPCGvFSzcpe7vrawt3oF3xIUdVDstlfZ0SNmY+r398ICytfRAE1ZIY5sCIKQ0IZdEgjE1StU6zHJ66H1YAfrbMusBxeDvVbXypKhjmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yP3/Nak+u+59rxDuDab5ZH0FoHa46InfPM75353J2Q=;
 b=gRUsJ2D1W2ufRl05Dd7PPRq+NqQ0XBMAHHosveoZX3PoXTdFibsIlvdNt+9pfpJRMwRu09hERwDpNFB12C+lb4tSNWtzTpFgr3A2Soa6I2jEHDDbiEinlqYHq/f9USyhslA5AgEE7n5tqnnAWMy0MfhpdqOWzHJzMPVpE/mPWTH9twF52PhV1+E5dlsKUDCM4YkAu4UpF9vojJnF6sB65qIuMHGPuG0D1BfwTFVIEodxNpEYmHBuJLk+aBq1qhsKqi1K97Dz4HbVfpbtVzh8w3iHZWHTw4c41sv9nAsRwVbraFgklNqQdUkb+aMDvUGxceeawRy2edUo2pAgGyqplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yP3/Nak+u+59rxDuDab5ZH0FoHa46InfPM75353J2Q=;
 b=KGF5yX1GJvsNfbvy3HG+3Fme/RW9G4D6Kmesdd/i7VUmc+alLBFrl76I7fdVNbAMN+n+/miiEc6pVNhFQm6opfyXxBiDl+ID5T2aEj112a7n+5iC1OELqn4FWYEVXgkltnZK3Xx6fboEEjrhgN+lO9RpalglCKurLksiT0bA3H0=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LOEP265MB041945.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:503::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 09:07:56 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 09:07:55 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: Improve logging of unknown freelist
 IDs
Thread-Topic: [PATCH v2] drm/imagination: Improve logging of unknown freelist
 IDs
Thread-Index: AQHdXISquDK3D3Y37kGtlAC9pYWIxg==
Date: Thu, 15 Oct 2026 09:07:55 +0000
Message-ID: <79a0931801cf17535ecef4fdc173d77d7038f5b8.camel@imgtec.com>
References: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
In-Reply-To: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LOEP265MB041945:EE_
x-ms-office365-filtering-correlation-id: 1fdc2131-4969-4e06-e062-08df2a9bcd08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|366016|38070700021|56012099006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: iuzf94ZGOibgGwJBHxuYs0fGswoyATtYS1YNz4vWzs0yU5Rh154MdVAR+Dr6yxGhKDJ+q2aPcIqSQWjW2yrntRG+eRRqaYGBVE9OltOyOQDgcsUZ9stXSAoj2LmzTenJBpOUVfywwEgFH3bamZ5urxn1Vlp+BR9awS/utNPjmYdDHDMFx+LsludNiCzNb00WUVh1EF91CAACTKf1YT0vOxNgtmwuHWbcGyXrDeZLuLGkAicDfBUC+pAE2WECs8bgNWRu+p789R0+q8Bfu+MjL7XOeZcJ4SVqJ6tGfWwiG9+TXgDVr5nJEvOPgKYJcDJC/f7/fczXBlckW/L5CIFirdLsY3NNrxWfM087C+jHCtaCJxl8kev1HLPKtMpPw/ZhuwG5yU5pPb5elcLp86Z3NhT3X+XzCHzcc6nQwIHND2crT70+ySS28h1y/M/6DPhBv2tlynNxRsZhFlSKE6EAXrTyk/UZ2dA3ODxh2Qn/O6WLt8QTj9aSwNRcqf3P7fMLVQKz1o2RnVtvQmklsbE+vvGRs8w6V6TKs2QRGhTKNqXfNRSn+DKsYU7hAZ5AJhsx/aUJI5nvyenmWL2gGINQEgFu7pirG9Hy0HUHYZTO6/6BtAfRewrg0G33ItfiVuhGNBj0FL9Vilmx+cROQ/E/K0O+ZQ/hbr1ivdTY1Vpln4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVVGREk0OHNIdXkyeWxrR2tsWmVvQ3BLR0NZbkJhTXR0aUhwclNiVEcyWVN6?=
 =?utf-8?B?ZjRVTXBpRUhsVTA2enJiWmtuN2crN2V6alVVSjRQSzJ2aG5vYUhEZ0QvaTVP?=
 =?utf-8?B?VWhaZlRnOWlHczkzazNldVkybzVIOFpOS216TVlDeGM0enlQVWV5Wkx1M2Nz?=
 =?utf-8?B?S1lTOFpSWXhmQlBzbjhYbnRxM01Tei93bnk3VzBveXd6bjc3QUJPUDhvMmRh?=
 =?utf-8?B?TnV2L2xRN0hJMEhUalV6b1JzRnErYmF1OWlBMWVSVVFSTXZ4VFpQUldOekUx?=
 =?utf-8?B?YVBIeWx2VXNMSmJPcXppVmkvYXMwc2dVOVBpV2dTUHF2T0RVTXFKZzA0b21W?=
 =?utf-8?B?L2FpS2hxOTREOHZ4dHJtVGpIYUJBL0VnelY2WHF4N3hycXhWdFlVUlh1UCtU?=
 =?utf-8?B?TGlGM1FEN0M5M1ZZOXF5MGJBNHp3MFFMbVd1bmRWQmdnTnZZSk55VTVZNEto?=
 =?utf-8?B?alN3NGE4R29EdUg3SW1WT2JidmdFS2R3cEt4eVYwclczTC9Lc1Q4cTJrb3Nv?=
 =?utf-8?B?MVdjTHlvV2o5cituRExraU8rRFIvUUR1Zm9va1QyRXRoYXZZTEdMc21KVVow?=
 =?utf-8?B?b0RWajRUSy93aE5lWmRxeStJN1BxUm1kNHJ2SzJBWW5xUW5QblMvK2V0VWJp?=
 =?utf-8?B?bE5sN01YSEVqRzUySTh3RlBPak5VM1ZXV2FuUVcyUm9mejJNYXJRaTJ5NlV6?=
 =?utf-8?B?ZjMxR2diZjFRN0EvKzFCUVVSY3paajUwUmxBS0J5SE9BTHAyUGhkbEF5cTJO?=
 =?utf-8?B?WnQ2TGJqTThYNDFjeVdSNTNwSms1VjBnZ0M3aktPd2RSL0J4bEQxOE0zZjdI?=
 =?utf-8?B?MlNZTzRRd2tlNUNrRVJ3YmlFdkthaWVTc2VhSTVyRHFadTFGcHMzM2pCU3Fy?=
 =?utf-8?B?SlJ2Rnd2SHVPSFR1TTBaNGFpcVpLT2NadGsvNWZiMk1pM1Z3dGdnQ0dLRzFh?=
 =?utf-8?B?Y01Dbk1scHd4VlB6b1Z4SGVRZzZXTHhET3RTcWVxUi8raEowYlB2N3BOaHVp?=
 =?utf-8?B?YXpOMFplRVUxdnBLRkROL3N6cnZhbzc1WjZRTXl5UDlmbndyNElsRWdES0tH?=
 =?utf-8?B?MEgrVXJML3VVZGhsdHYwQ3lrZVlZa2cxL1BpeGpaY3ByRXlHak0ranBTMWNU?=
 =?utf-8?B?MGtMQnRnK1JUK21ZN2oyZkM2T1JyMm1uUzRKYVdIUVZSNDRSajAwYkhDVkJW?=
 =?utf-8?B?MFJzTjhwVXpyZlJrK0daUVJIL1hSbDBYWUlZS3VCUTlGQ21ZU2JLTnFiY285?=
 =?utf-8?B?YlVQM3d2dVpNU3hhTExwd0FiTVd5eGZLbURWWmZqTDRDNXpkV2I2a05sNlNy?=
 =?utf-8?B?enBpZmpVQnZYVnNZUk1zL1BzZ3FSbGdvbThuS08vbkkyMmd2MlJ5dlplbWhD?=
 =?utf-8?B?eTZUeStQWk02dHpUVVppYjVUM2tteHhmVExYWDZTK1ljTCtQTXBleXlsZnh5?=
 =?utf-8?B?NnNsZ0crN01vVFdDR1drdTErSzR2Y0x2UGNnVEV6Sy9JNWVpbHU3Q05kS1dO?=
 =?utf-8?B?UnVjemdtT2xmSHR1ZHZJaVViYXBCOVRUTlhGMHRUejZjaitEVDBVK3hrOS8r?=
 =?utf-8?B?akxKRFllU0o4amhic0kvZHFiUWRMeUw3eUx3VzY0RlVHTXQ0VXRQSTYvUTJC?=
 =?utf-8?B?b09uZUR3T0w5NElKMlFYcmRHR3ptUUZMT3M0ZXFER3N3TkpvcTJSd29EMlVz?=
 =?utf-8?B?ZU05emNyU0pDQm4vZGVOQ2o5eHM1Y0VpaDZEL1VIYmE5WE9PQkJEY1pCeFFt?=
 =?utf-8?B?MDJhcUx3QVkyMlpWSDdQcjdaWGpySlVaWlNCclc5ci92eTlKMXZPQTR2ZUhT?=
 =?utf-8?B?cEtBdWhUVWhOanYvdVp4cG5hNUY5OEV2MG1SNVBOS0F1M215RHNBYXBaVkpm?=
 =?utf-8?B?ay9tOGVHcmtpck1zVU55U3lDTnBpc0p1MmlvNnRJUDBHQjlzQzNsQVZrZzNw?=
 =?utf-8?B?aDcrWVpXYVArMjAzT01zTGl4ZGVMVEpWQjZPNmFFeE1Od21OVHZHNkIwb0Vm?=
 =?utf-8?B?Q3FGMU9wK0o5N1B1VEVEbm4zMnFqREZrME5YblZHWnhiODc5czR6bkhaVmlE?=
 =?utf-8?B?bS9RamxJSWxNUDV2NFU0WmppV09tVEJFbG00MzJOZklHeHZvSHdLNHV4WVdm?=
 =?utf-8?B?T1VYd1Y5eTlVS1pRd2dQSlVOVkx2cExZR1ltK09qL3pxaUorWkxHcmtFcEty?=
 =?utf-8?B?bHIyVVU2eVlDbWxMNnhGeGp5MjhHOUxwWmJ4OE94bFZzUkRIWStRZU9Gejdk?=
 =?utf-8?B?YzlrZnVHRWZpaUdVM092Nm93cDBwSzNhejZrWGFmUzdYSHp3TUVrQTQ4ekIr?=
 =?utf-8?B?bmFwUzFSYTM2MUt4VWwxSlhlSTRoaTdQY3BvZVNFMnRHc3lFUzBITTYxNFZC?=
 =?utf-8?Q?fsr9HDUKcZ8S7yY69o4KnHfWxWb0G3N80MxzkRIvmPdN5?=
x-ms-exchange-antispam-messagedata-1: dPh54uC/rDO1hFacXHbw8bpBkTBSfb4dawE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D924B4D62F61E5489399B2752EFFC0DE@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g01CX3eTftxEfaHc4M9jJ3BqZgwJestW7uP1jODPLzkHsO+lwoI7tm/q52Ol5UedcZXhE5P9SmpXlAkhqugn/SRGeTKMLvjgaNdbMrkHJdrmmeFm3HH0GjWmoi5Xc+zeP+T17jO/iMcfvjlydBAxQIu6waEKReFCndt50GtnSWKxzV2/LB4imjgooNZHOdiBUF3YTwfP7h6DzGOn3N3DzgbLJTTc8KCy4cDkt0zQENfUEgs43/yb0TN1Xwb8VFOElSC5QrYl4FSSsLsnmwRkUNK7PSWHR/IcsChb7UpVgcdD3inSguEnoRcvPGyym5AkrAODjFXZ+ettTk/+reTUIQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdc2131-4969-4e06-e062-08df2a9bcd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:07:55.6992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOsA0H3PqlfYpNudrswdASLlWL7fNatHQ1HwEdanLwik1S9NZea5ucbyZ7WZkwHqYC9EYJObpzJcZcTn3lxnqLzqZtP0U4h+ZZjB3cHUvqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOEP265MB041945
X-Proofpoint-ORIG-GUID: 4AYJOGeEPCwhWOOg-4m4bjPJeN033WIy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX2huHsJixHQaT
 MxBIbM28l2fZSKyFZGRO84XmnKCO3j8tmkC/CXp3ulfUYnFh3V9Q0RQEu7EjqTeq37fhm2naOw3
 wxlftsyXtjEyD7rerdFFx9NyrllnXkZ3Lz65B00JQI2qU/H7jR8WZw5ENYfE7AiGjvvJBhdCPCr
 Xe9ffg9K9y1NduXPHsbWj5uUAp6pDOfp+FK9BYu9fJIA8hoDmzNgS4vvapI31jPJofhyUrmDW/0
 RRF7gz+Lg1GZFBuCrFl9HjKVZ+a4Bof71u9lDJPBgEb2sTRbU2uwNi5tqwKrho/9WhlWvFa53ce
 YJLQFiQI5VRGelgPi0VSmtJjlHKL2BvfToeGlxa3xUD7gwgQ9Twb8yG8UqMnhTRE21yGAxjJFVO
 BO8LUA2QmagLGuwRKCipXcCUWvxmcnwzEmrPWwhz5rcJnjomZ0Ux8XqJKGAxpHTDbzMSta7Kh21
 at0KKdyMefrpqvWTrMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX5Z6mTOuC+cYp
 FeyGDBffBSPEbP5xWzyA4s8i8jEtF3alQ+ZDbCHdYJNHxguCyq2ElK0hM3f8M3yawI7QHen+Ncv
 duNw7R3v9ecJdvw663EJkYdmuU+Okc8=
X-Authority-Analysis: v=2.4 cv=OO6yTiaB c=1 sm=1 tr=0 ts=6ad097ee cx=c_pps
 a=Z8r6FvoT1MCTxwa/Qa2FPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=e5mUnYsNAAAA:8 a=Q-uQ7EVZ1i4Vm26aEc4A:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 4AYJOGeEPCwhWOOg-4m4bjPJeN033WIy
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

T24gRnJpLCAyMDI2LTEwLTA5IGF0IDE0OjA0ICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IEZyb206IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNv
bT4NCj4gDQo+IExvZyBmcmVlbGlzdCBJRHMgbm90IHJlY29nbmlzZWQgYnkgdGhlIGRyaXZlciB3
aGVuIHByb2Nlc3NpbmcgZnJlZWxpc3QNCj4gZ3JvdyBvciByZWNvbnN0cnVjdGlvbiByZXF1ZXN0
cyBmcm9tIHRoZSBmaXJtd2FyZS4NCj4gDQo+IEluIHRoZSBmcmVlbGlzdCBncm93IHJlcXVlc3Qg
cGF0aCwgcmVtb3ZlIGEgV0FSTl9PTigpIHdoaWNoIGlzIG5vdA0KPiBwYXJ0aWN1bGFybHkgdXNl
ZnVsIHNpbmNlIGl0IGlzIGtub3duIHdoZXJlIHRoZSByZXF1ZXN0IGNhbWUgZnJvbS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1QGltZ3RlYy5j
b20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEZpeGVkIGFuIGlzc3VlIHBvaW50ZWQg
YnkgU2FzaGlrbyBieSByZXBsYWNpbmcgZHJtX3dhcm4oKSB3aXRoIGRybV93YXJuX3JhdGVsaW1p
dGVkKCkuDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYxMDA2
LWI0LWltcHJvdmUtbG9nZ2luZy1vZi11bmtub3duLWZyZWVsaXN0LWlkcy12MS0xLTk2ZWJjYjEz
MmI4MEBpbWd0ZWMuY29tDQo+IA0KPiBUbzogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBp
bWd0ZWMuY29tPg0KPiBUbzogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0
ZWMuY29tPg0KPiBUbzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4
LmludGVsLmNvbT4NCj4gVG86IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz4NCj4g
VG86IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBUbzogRGF2aWQg
QWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT4NCj4gVG86IFNpbW9uYSBWZXR0ZXIgPHNpbW9uYUBm
ZndsbC5jaD4NCj4gQ2M6IGltYWdpbmF0aW9uQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZnJl
ZV9saXN0LmMgfCAxMyArKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQpSZXZpZXdlZC1ieTogQnJhamVzaCBHdXB0YSA8
YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNoDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mcmVlX2xpc3QuYw0KPiBpbmRleCBlODVjYWM4Mzgz
NGMuLmVjMDJmYmJlMDE2OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9mcmVlX2xpc3QuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX2ZyZWVfbGlzdC5jDQo+IEBAIC04LDYgKzgsNyBAQA0KPiAgI2luY2x1ZGUgInB2cl92bS5o
Ig0KPiAgDQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9nZW0uaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJt
X3ByaW50Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3hhcnJheS5oPg0KPiAgI2luY2x1ZGUgPHVhcGkvZHJtL3B2cl9kcm0uaD4NCj4gQEAgLTM2Nyw4
ICszNjgsMTIgQEAgdm9pZCBwdnJfZnJlZV9saXN0X3Byb2Nlc3NfZ3Jvd19yZXEoc3RydWN0IHB2
cl9kZXZpY2UgKnB2cl9kZXYsDQo+ICAJdTMyIGdyb3dfcGFnZXMgPSAwOw0KPiAgDQo+ICAJLyog
SWYgd2UgZG9uJ3QgaGF2ZSBhIGZyZWVsaXN0IHJlZ2lzdGVyZWQgZm9yIHRoaXMgSUQsIHdlIGNh
bid0IGRvIG11Y2guICovDQo+IC0JaWYgKFdBUk5fT04oIWZyZWVfbGlzdCkpDQo+ICsJaWYgKCFm
cmVlX2xpc3QpIHsNCj4gKwkJZHJtX3dhcm5fcmF0ZWxpbWl0ZWQoZnJvbV9wdnJfZGV2aWNlKHB2
cl9kZXYpLA0KPiArCQkJCSAgICAgIlJlY2VpdmVkIGZyZWVsaXN0IGdyb3cgcmVxdWVzdCBmb3Ig
dW5rbm93biBJRCAweCV4XG4iLA0KPiArCQkJCSAgICAgcmVxLT5mcmVlbGlzdF9pZCk7DQo+ICAJ
CXJldHVybjsNCj4gKwl9DQo+ICANCj4gIAkvKiBTaW5jZSB0aGUgRlcgbWFkZSB0aGUgcmVxdWVz
dCwgaXQgaGFzIGFscmVhZHkgY29uc3VtZWQgdGhlIHJlYWR5IHBhZ2VzLA0KPiAgCSAqIHVwZGF0
ZSB0aGUgaG9zdCBzdHJ1Y3QuDQo+IEBAIC01NjQsOCArNTY5LDEyIEBAIHB2cl9mcmVlX2xpc3Rf
cmVjb25zdHJ1Y3Qoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsIHUzMiBmcmVlbGlzdF9pZCkN
Cj4gIAlzdHJ1Y3Qgcm9ndWVfZndpZl9mcmVlbGlzdCAqZndfZGF0YTsNCj4gIAlzdHJ1Y3QgcHZy
X2h3cnRfZGF0YSAqaHdydF9kYXRhOw0KPiAgDQo+IC0JaWYgKCFmcmVlX2xpc3QpDQo+ICsJaWYg
KCFmcmVlX2xpc3QpIHsNCj4gKwkJZHJtX3dhcm5fcmF0ZWxpbWl0ZWQoZnJvbV9wdnJfZGV2aWNl
KHB2cl9kZXYpLA0KPiArCQkJCSAgICAgIlJlY2VpdmVkIGZyZWVsaXN0IHJlY29uc3RydWN0aW9u
IHJlcXVlc3QgZm9yIHVua25vd24gSUQgMHgleFxuIiwNCj4gKwkJCQkgICAgIGZyZWVsaXN0X2lk
KTsNCj4gIAkJcmV0dXJuOw0KPiArCX0NCj4gIA0KPiAgCW11dGV4X2xvY2soJmZyZWVfbGlzdC0+
bG9jayk7DQo+ICANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNmUzNzVkZTk5ZDBjNDIwMTY5
NDgxZmNkMzYwNjQxNzdhYjU1YjA5ZA0KPiBjaGFuZ2UtaWQ6IDIwMjYxMDA2LWI0LWltcHJvdmUt
bG9nZ2luZy1vZi11bmtub3duLWZyZWVsaXN0LWlkcy04YTY5Nzc3ZmQ2MWUNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gLS0gIA0KPiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVj
LmNvbT4NCj4gDQoNCg==
