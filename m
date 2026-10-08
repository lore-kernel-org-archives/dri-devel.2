Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E0DCA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B35910E8A2;
	Thu,  8 Oct 2026 14:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Je2eJQrA";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="cHT3eOe4";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DF710E8A2;
 Thu,  8 Oct 2026 14:25:51 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BIfjh2903185; Thu, 8 Oct 2026 15:25:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=l0bGVCxl4fHU9YgHaZwQ+YCHdI7Kd16+Che4lkw9in0=; b=Je2
 eJQrAhJJYXhAjzVkrXwGt/N9/KjY8ru4rFLR3BF0gyhGwmRUoCGeimjkPPSD9tTI
 7fEbaJOQnCV5sysWjTsCVTv+Y20+/QXfC8vMNipZHy2jtCSQRGfGRdIUS5lTzgPS
 vEj2DnmL7EjEP1PXbDLztd2o+txmcbhX7I6XQ3OvoAIRLHFX5SCpxtQ0nZMd1aXO
 ZepcnN6k14CRMQKBG3AMqj4Wz0zHIFaAeOMP8tXilUzpjiynCgimOjI+OCadqwZ/
 qtV9kF+6J3awAJ3OXYusva+3Tn9HxH32u5Gl5FhmFw6E6OzMgrllAntgWf5qPhCN
 d1kd/5FRfYQ7+pY2nVg==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h57ek1k6r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:25:32 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3p7KGknJx8KDr/53NIQ3ReHNydmgBaGFrYIvYjs5KEyreLfL8TxzTuLtvf3kmAB4PjJvBFh+kjEo2Bd6E0x63/BaUsSfSzTgbU6+/Pv0wFwOJU/QWprk1yK0aqogGZJ/stJLUX6CZm72Jb39ze8MYQfUOKVVx0vBSZnWQ3TwCtDFY5zCLQ58iAP4sXpIOYDWj9lthe6HBJ45PzX46T+TUD+UXLA11OpbLvvTL7F/Azh+J/qB8jR0BRsVf6+ySbVY/C+mD6pdw3cqq/8W/OArTPKRQ2dOq1Rg+BoRCLRZJurv5ypk0sZqi2V8+wxD5RtB2HpOQmInDGbffR339nRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0bGVCxl4fHU9YgHaZwQ+YCHdI7Kd16+Che4lkw9in0=;
 b=c1wrlZYCajNUnX6fHfxVASe+HZ4JiBcyXR8u2/+SZ+aNOeC8LBnNJS8x+Ptl9LF5IeNan3SXRn/lxpzZ+7gh1Rmz7sPlHvd6sZoKdekod+k1ycPSt2UazgSWRyUvI/lnk1TbSybNZVFbHlwdnPEDKVUsTHU9HM5aIym1/BiHfP6sVYx3dP11E525uBAMXkrVE778FGqVNa81/5/5rkM9U/G1XCeP7hQUysVOLzBvvurKU4LureuHIkWNXOvtW93bY95Kzw0cPb2wWCnUgtL3E2S0E9o3LuVBBC2N5jRzBnL47Z3yl09P734JrHZHrOV5onPrPrDLGMmNfEZVcFn3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0bGVCxl4fHU9YgHaZwQ+YCHdI7Kd16+Che4lkw9in0=;
 b=cHT3eOe4qYPrckElPMIvaz7dWJPIy6Voq7H+ZW4dGbjXPXN3mNidEA00H4zH0tQ8PJbl6Y8QE8RqKtlHYeDRqTD/Pee5s4AoHfhtRXgNLJszVgs0Obu665jgC4ALKegl89SXyrUvlVmpIOWk63ZiggJe/qiaYBXB8C8KmdB7eEY=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO4P265MB6968.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 14:25:29 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 14:25:29 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "gye976@gmail.com" <gye976@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, Brajesh Gupta
 <Brajesh.Gupta@imgtec.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Topic: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Index: AQHdVzDeDJFmDbJEh0GS0Onf9joPdw==
Date: Thu, 8 Oct 2026 14:25:29 +0000
Message-ID: <67ab8185350907d6fc6ff15ffcef4012902e0d96.camel@imgtec.com>
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
 <64b915fe3c794567a04c955fa89184204e3b9552.camel@imgtec.com>
 <CAKbEznvDanJtt8yEL2UmTeLpA1SZOT693E6AD1Xau+mU4Mztuw@mail.gmail.com>
In-Reply-To: <CAKbEznvDanJtt8yEL2UmTeLpA1SZOT693E6AD1Xau+mU4Mztuw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO4P265MB6968:EE_
x-ms-office365-filtering-correlation-id: 0d58a98c-0308-43b8-f94d-08df2548010c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|10067099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: 4i/X4FPuAhJPNnC9uvwcpteciMYcWI7pfZ64S0z/3XvCcfdmQX2QbfSgIlM+niBOu7rhwa5nMwkEyDyEdZZ9o48Pgya6pdNii31J/9UV5bRz2kkFQazsDDPeYda6Os8jO/RHku2Ir338V0bnw4TafsUe8yVb7WLMTsWxUiAydAKInnsTvv6kBkw1NDCEraHMLM7f/JBE4sKdSjS8pL3zl6jkcQH0TVCvsfrfpo8z60+vxQSGnrxOf+YRWKFUXbjLUNKiAAmUYykT4umSmIT9Pc5DjiOPJiUrBhxKvulRiPVjVQLbglf2ZMmNu8sY1oM3C3NPf7QLnO9ok8alkqv2CVK0iLK8LBrBbr8MPmCskjkvn9vFW3apq3KUU3iOLcrM8yYrhDpk5HugIYkN+D6aUGmorv3QkorJI8jv1SppHwCk0ZxjO5k+Phwbb29DyqFijtD8j4kVo9DZGwDw76tTJ/ghmVMighY3oXbTDtdeMHIxu/zTyxiNYy4ZPn0WfDfP4mZM8x35yzfdqIdXyN5Jogiwu3s31/Sb0c9xoa92OH5iPsiCeGzI9RY+F7KA9Bwie4dtP1oyViXjGYKiJHE8IB6vlqDDTgGfqUDnrYWKsjyrQ4AGSPGvllKijc7AxeZFHElz/N18FXB22eCzlku32B4DFAOD2LdookHCoNfwFor1GJNGkZMU6JAQLxBIJ6JrJODBRdIXcNY93JKiZuyqGSUyVk2P7XHNvxXrv9j/pNs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEY0bW84dmlFR2hOSmxJV2U0WXp4anhoT0E2Yk1vU1A2ektDcXZoZ3ltNlpT?=
 =?utf-8?B?aU5TUTBEM1hGZHlnRGtVYU1RUUlYMk8yemhyUDlQTCtycGdBQWtnbzZBOFlD?=
 =?utf-8?B?UlQ0NnZ5OGRZZ0VBRXNFRk8xS1ByNXlEMGNDTjdpcjgwK05vQmNLSU5NdFM5?=
 =?utf-8?B?cU5Mc05iLzM0ZTRqQmR1V0E4WW1GMGpkTTJXU0lPblVuZUtScjdLWkZoQUR3?=
 =?utf-8?B?YmE0cE9QelZ4elB0RC9rZGlNaC9BK3VVa2xxOXc4Z3IydEhTYlcyc2Y3MThP?=
 =?utf-8?B?K0lRUjNHbkF2S0RGaVdsL3FjK1hxa0h6elJsMktrZlppNUJ0ek5wNTJyeUVD?=
 =?utf-8?B?UGlEaitoeldwKzQwSTRBdWNTdldQa3FLaHlJMkczNk9KOWhUcEJhT0RSeVRQ?=
 =?utf-8?B?U2tBd2dSUDZ1ajVveEJNbnNGUDcxL3dxcmFYTERPWkNPQWVjZ1NKa3pHUXcr?=
 =?utf-8?B?WTE1L2FvUmROOURxb0NLT2pYYVA5VnQ1c1dRSTh3RHRXbTVRSjhlUGJwZ0p6?=
 =?utf-8?B?bjU0dmFDMDBvR1hzeGZCWEIrNTZOcUh1M1FhYTBmdGdJdlI2Z1RZMmxHSTAx?=
 =?utf-8?B?UENodWVnMVBYLy84NW8yVjlVMHdBNzdIeGZQd2svejVydWZkU3FONHdEKzQv?=
 =?utf-8?B?WHdXR29BV05sV0hRdUZRNXN3dnNVNDJNV2pqaDdQMWpjRWlPaWhUMElFUi9W?=
 =?utf-8?B?UERrMlhRN29yOTNGSXFYdWJnSVFIYS9jN25ENmp1RW1DbWc2WUxEUkFGcFp5?=
 =?utf-8?B?Y1RUNG1qMzBvOC9oRG1xcVZ4NUNxVlRsbUVtTjJ4VkV1L2xqbjc5U0s3SzBL?=
 =?utf-8?B?MlJ5Y1E0MExRVG1jOGIwa05hVjhHc2hxV3dOWkdKV1FiQkNFRnlZZGJhNUd3?=
 =?utf-8?B?YmxFQTRZSEV5K0FuZGRPc0JmOGs1eGE5RDZOUGx3Yk5Pb0pPSlhWeUw3NW5Z?=
 =?utf-8?B?Z0FhSCtGbVRiSThDWmcxRnRybzNPQ08yczNaTndsaGJRTStmZ1ZWVHlBbWhi?=
 =?utf-8?B?U0U0WmsyZ3N0YkFHMnJXQnFaNkhXMUI3eWFPSmpkcEs2S1d1bkw1RzJvZ01G?=
 =?utf-8?B?d1hZRmNYazVWRUphRmJ0RFN6ZEtFR3VuMUREV0J1RnI1YnpaZmI2NWtvaUNv?=
 =?utf-8?B?RkZ6Um9PdHZGcXBNeGdDZzhPdG14QkpEOHkzaDlOclpDMkg3RTd2TFc2QnJn?=
 =?utf-8?B?ZnUyV3FBRjM1N3hKNG5RT3g4cDJlanh5ejVtS0JTNUppMzV1MkgrWVRZZ3ZO?=
 =?utf-8?B?Q0dLM2JWb0duWFhMaTVYV2pqakFVbkpiV2NaVjh0ZjkxVUFOVkVjeEM3akVi?=
 =?utf-8?B?a1VuSVdIMVNGRFZ3RGlGRkRickRFeVJucFJ4MmJsL3A2b3V3UkErSHRMWGN2?=
 =?utf-8?B?N0ljQ0NDZzZlOWJpdVM0b2p0ZHk2MGx0bEN1Qmk4c0tSS0hTVTV5aFUxUUpE?=
 =?utf-8?B?cU56Wk9Zb21rTGdMNWE0K1Bsdnl3ZGY4TUVmVW9Fa0VzYTZMek1wQkJxOE1j?=
 =?utf-8?B?QnZzUHc1Rkg0ZG9HTU1UN2hPY2JsNi9RZ0NRQjVsaThvdGxKUGV3eWY5dXFx?=
 =?utf-8?B?MzRxdytsMXZXdTJ5Y01UakhpcnlIcTZ6dFkzeFBaNVpnQlQ4dTlYVk9rdVMr?=
 =?utf-8?B?cEwxRFN3eEtFQmluajczQy8wY3hGV204Y2pLMWc4Zm1HdG81Z1pVeDlJa1Nx?=
 =?utf-8?B?K3JZaEVsMzdKZy91bTdmOGRydnVSK1VWS1p1TFBoK015anphTldWL0RpMDFE?=
 =?utf-8?B?VnpWbUp3SnFWOFB4eTdyZi9SK0gwbEh0YW84WjZOMWtjUWZ2QVRtSTUvQzdX?=
 =?utf-8?B?aWFINitoa2pQalhiQnYweHVEWDRZWVBiRTJtTUlUcDQ5Z3VhZjdRQ1c4R2lO?=
 =?utf-8?B?MUhaeWVKc3BHRHF3UU5DNU5zU0pYNk50MDEwNk1MS3F2a29OZkdTMDU2dE44?=
 =?utf-8?B?MnpaU1lGaHhrQVhsQlZsY3R1TFhHenA0Vml5V3FCU1B2bFZHdEEvaXZ2M2ph?=
 =?utf-8?B?ak1vcnBlUDc5SnNLVndVODF0V2djcHl0NWZISFZQWE01ZFJUWWdGV3I2bVow?=
 =?utf-8?B?M3l0RzJMVDA4K3pxSXRYSUg4d21QNWIvWDNRbkVPeXdqbXN0NkovUWJxSk1Z?=
 =?utf-8?B?ZlVlcW1rREpMK2NlSTY3bVF5WEVISnRHdUF2TFVSYkRRbmVUVnllclZoSjdl?=
 =?utf-8?B?UDE2akUzOFhzWFczUkRuQTNkV1FFSjhRSXNud2ZyNlpXbk0rREl2MlNqbzZS?=
 =?utf-8?B?Z1RnanY4VlNFVTJSZ3ZFR2FhdEtMM0xROTU4NkhZSGdkMUhaL0JTMkl4bWVo?=
 =?utf-8?B?MlFKTHg3UElFK20xR3VKTVUyTDV5UGgweHNuaElwOTlidXE4OG5XZGlKQlBI?=
 =?utf-8?Q?05VfMiQXFF6qzh3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99AB5A90C265CE4E80EC784314616941@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4azf8J0QP0D5/rA5AnBZbPcWjkCrrZacXd4/z/eooW72shi8GtuI/0DOekpBa6BtIqHBYgjGMYgK3HEXfVXtg0ej0k69DkJncvjIWO8tfdvooQmx98Wh9P47GjHARlQeTlTUSVaP/haLkkNRC2TtTDUsasbC15osFqkSQXujzuKOf1IzDTiE46jcd3pxwZsVILjPorMtRMFCxqKXKdTqbvQmGa5rq16g5SxQ1Yby4EJTXjI8DNfA9rcd5oEFdICqR3b1AOeSAnH7JDEU/IV3tIho4L3EFCd6wPlUPxUuVJ2R8VpASnvuo8vtJj5kuKCtEgZ7T8UZgai+921vm4dqwg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d58a98c-0308-43b8-f94d-08df2548010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 14:25:29.5010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnfwgETC0+gneE/E/rq9lQnuhvM3v40Q8rYI5Ltkx0GdKrB1hUNbg6EsCTd8UeINOCOFI+0bPNJ1kg4vsuPAwsfM1gF/3v5+8aKoFYniTcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6968
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1NyBTYWx0ZWRfX1xuYpobJEhUl
 HVb099BNsqvLWQbOO25yblsize9FBjaJtcvkmXx2YeRsbb9fbHhCXHjtajhAlVMgHP2O/ECTmK4
 eIww1/OoPWIwkZI4K1tD2Nx8/rZqmgQ=
X-Authority-Analysis: v=2.4 cv=Mbj5KJ/f c=1 sm=1 tr=0 ts=6ac7a7dc cx=c_pps
 a=GwulDlvyJS+gHpL3b5V7Dg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=yj5hb4kO8J_cCrWWROgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1NyBTYWx0ZWRfX3mVA8CYgQiD4
 F/j3bc/CqXu2pzLC9M2VSoh2ZSJ8L6THiP6dTBZeAsIJ3tsB1QNXFGjVadI5HBXOvQKGQl7oWCr
 n7Y8xt9pb1AbnfkpkrPEaRHOIva/WR5Ufx+ZxQJMSHdrpz0xze+rhO78UlHY8ux7Ml1s5dgzFBQ
 KcYWlpIxiyNW7k2d+xP6SMF6hS4pDXqsT+ptIKfe0uFrbbMU4Y6atDyClEKi1wSTaaxllxRR1lK
 bLD+yyVKaE4SSy6osJORm+m1j0e4HlsKhlBe4DG9lddQeEnRd5oMiNBVCHEVe2IKe6s0o+vdshs
 eo3WVCan7o1Nud7X7NvnVpP8IIXTjqThbFjQKNzVBhkmmzWNck8OUvZNCu1a2nuXBKzQIRDkYnv
 Gql83fdDBsNHqeQC1VnV5dwT9nlOuqYabVQflf79VoIpqtfDT9K2DGtbqta/BRx5Xs+hPhnzIa3
 SMHBIRkEBU2mT/Zm5Rg==
X-Proofpoint-ORIG-GUID: mGVRkv10AVmVON0dDmpQPZr9tUbO447j
X-Proofpoint-GUID: mGVRkv10AVmVON0dDmpQPZr9tUbO447j
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

SGkgR3lleW91bmcsDQoNCk9uIFR1ZSwgMjAyNi0xMC0wNiBhdCAxNzoxNiArMDkwMCwgR3lleW91
bmcgQmFlayB3cm90ZToNCj4gSGkgQWxlc3NpbywgQnJhamVzaCwNCj4gDQo+ID4gDQo+ID4gU29t
ZXdoZXJlIGluIHRoZSBkZXNjcmlwdGlvbiwgY291bGQgeW91IGFsc28gcG9pbnQgb3V0IHRoYXQg
dGhlIHByZXZpb3VzIE1NVQ0KPiA+IHBhZ2UgY291bnQgY2FsY3VsYXRpb24gY291bGQgdW5kZXJm
bG93IHdoZW4gYSBtYXBwaW5nIGNyb3NzZWQgYSBwYWdlIHRhYmxlDQo+ID4gYm91bmRhcnksIHRo
YXQgd291bGQgbGVhZCB0byB0aGUgZHJpdmVyIHByZWFsbG9jYXRpbmcgYSBodWdlIG51bWJlciBv
ZiBNTVUNCj4gPiBwYWdlcywgZXhoYXVzdGluZyBzeXN0ZW0gbWVtb3J5IChzbyBtb3JlIG9yIGxl
c3Mgd2hhdCBTYXNoaWtvIHBvaW50ZWQgb3V0IGluIHYxDQo+ID4gb2YgeW91ciBWTV9CSU5EIHNl
cmllcyBhbmQgaW4gb25lIG9mIEJyYWplc2gncyByZWNlbnQgcGF0Y2hlcyksIGFuZCB0aGF0IHRo
ZSBuZXcNCj4gPiBjYWxjdWxhdGlvbiBhbHNvIGZpeGVzIHRoYXQ/IEkgdGhpbmsgaXQncyBvayB0
byBmaXggdGhlc2UgdG9nZXRoZXIsIG9yIGFueXdheQ0KPiA+IEknbSBmaW5lIHdpdGggaXQgaW4g
dGhpcyBjYXNlLCBidXQgdXAgdG8geW91IGlmIHlvdSdkIHJhdGhlciBzcGxpdCB0aGVtLg0KPiAN
Cj4gU2luY2UgaXQncyBhbGwgd2l0aGluIG9uZSBmdW5jdGlvbiwgSSB0aGluayBrZWVwaW5nIGl0
IGluIGEgc2luZ2xlDQo+IHBhdGNoIG1ha2VzIG1vcmUgc2Vuc2UuDQo+IA0KPiA+IER1ZSB0byBh
bGwgb2YgdGhlc2UgYW5kIHRoZSBmYWN0IHRoYXQgdGhlc2UgZXJyb3JzIGFyZSBlYXN5IHRvIHRy
aWdnZXIgZnJvbQ0KPiA+IHVzZXJzcGFjZSwgSSB0aGluayB0aGlzIHBhdGNoIG5lZWRzIENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnIGJlbG93Lg0KPiA+IA0KPiANCj4gQWdyZWVkLCB3aWxsIGFk
ZC4NCj4gDQo+ID4gPiBAQCAtMjMzNyw3ICsyMzM3LDcgQEAgdm9pZCBwdnJfbW11X29wX2NvbnRl
eHRfZGVzdHJveShzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICpvcF9jdHgpDQo+ID4gPiAgICog
QGN0eDogTU1VIGNvbnRleHQgYXNzb2NpYXRlZCB3aXRoIG93bmluZyBWTSBjb250ZXh0Lg0KPiA+
ID4gICAqIEBzZ3Q6IFNjYXR0ZXIgZ2F0aGVyIHRhYmxlIGNvbnRhaW5pbmcgcGFnZXMgcGlubmVk
IGZvciB1c2UgYnkgdGhpcyBjb250ZXh0Lg0KPiA+ID4gICAqIEBkZXZpY2VfYWRkcjogVmlydHVh
bCBkZXZpY2UgYWRkcmVzcyBhdCB0aGUgc3RhcnQgb2YgdGhlIHJlcXVlc3RlZCBtYXBwaW5nLg0K
PiA+ID4gLSAqIEBzZ3Rfb2Zmc2V0OiBTdGFydCBvZmZzZXQgb2YgdGhlIHJlcXVlc3RlZCBkZXZp
Y2UtdmlydHVhbCBtZW1vcnkgbWFwcGluZy4NCj4gPiA+ICsgKiBAc2d0X29mZnNldDogT2Zmc2V0
IGludG8gQHNndCBvZiB0aGUgc3RhcnQgb2YgdGhlIHJlcXVlc3RlZCBtYXBwaW5nLg0KPiA+IA0K
PiA+IG5pdDogY291bGQgeW91IGFsc28gdXBkYXRlIHRoZSBvdGhlciBzaW1pbGFyIGRlc2NyaXB0
aW9uIGluc2lkZSBzdHJ1Y3QNCj4gPiBwdnJfbW11X29wX2NvbnRleHQ/DQo+IA0KPiBJJ2xsIGFk
ZHJlc3MgdGhlIHJlc3QgaW4gdjMgYXMgd2VsbC4NCg0KU29ycnkgZm9yIG5vdCB3YWl0aW5nIHlv
dXIgdjMsIEkgd2FudGVkIHRvIGJlIGNlcnRhaW4gb2YgaGF2aW5nIHRoZXNlIGJ1Z3MgKE9PTQ0K
cGFuaWMgaW4gcGFydGljdWxhcikgZml4ZWQgaW4gdGhlIG5leHQgcmVsZWFzZSBjYW5kaWRhdGUg
b3IgcmVsZWFzZSwgc28gSSB3ZW50DQphaGVhZCBhbmQgYXBwbGllZCB0aGVzZSBwYXRjaGVzIHRv
IGRybS1taXNjLWZpeGVzLiBJJ3ZlIG9ubHkgdXBkYXRlZCB0aGUgY29tbWl0DQptZXNzYWdlIGZv
ciB0aGlzIG9uZSBhbmQgbGVmdCB0aGUgY29tbWVudCB1cGRhdGUgZm9yIGFub3RoZXIgdGltZS4g
TWFueSB0aGFua3MNCmZvciB5b3VyIHBhdGNoZXMuDQoNCkFsZXNzaW8NCg0KPiANCj4gVGhhbmtz
IHRvIGJvdGggb2YgeW91IGZvciB0aGUgcmV2aWV3cyENCj4gDQoNCg==
