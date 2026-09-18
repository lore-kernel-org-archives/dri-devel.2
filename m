Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF163C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CDD10F24F;
	Fri, 18 Sep 2026 07:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="FQ/8ccB3";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="KRJq+h+I";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F68910F24E;
 Fri, 18 Sep 2026 07:49:24 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I5xfRO2466816; Fri, 18 Sep 2026 08:49:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=kefXSW/XWiuqSXAZyOrCbwsmCOm4Cs/eQw1Odk1bPGk=; b=FQ/
 8ccB34/pfpXhZEqR8cUvP9j7XjjG7RCdVHUqHSSqk8G8FT+U4+ekVnBtKboFPAw8
 WzWp4oD0B8v966J5+Y2BFRgCSehuL5QuDFs6sj0eKnJ/021V80adAmPnKCOwgOos
 x7ypCc9WbLtu1RmXZD4BnTwgYjWScJGAoYEo0ycsXzDq4wlI6uIAiCfRQ1iJfHmf
 ZsdO5A+M7YoQ61EXMHocsLVSTBUNBuDoO5EU0axTcj5hFIj+9Xr5EAb02UN7DpDk
 /pY3h/knKIEADZ9JCuWxdAd9RewJXWlX66zjAUclYXIDRwNE9zPQ8ZD9z72h9vRk
 CzldpGoiQs9POoU+heQ==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022121.outbound.protection.outlook.com [52.101.96.121])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q4uxk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 08:49:09 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQunvkiDTl4eiTE7MZo+GxgaWgbBLTBtm4WJ/11tqtGacGGq5mMZEKbRTa8r0KQTnyz99HPcjd2stYLKwJQVgnHusgNRrAfW2Izx3+t1ywLjgApPZ8Ti+EmMkgJLTAX6iEqtxPDURfrYZPvXJgHat0VifTvvfhcZRGN+DNkNS1JbN1PztzlQ3pKwqOdt73X7rTfOERTVbJZ9LRil4FOSqiPAmKxLeAYsoS3lLZd6g/IxU0vCgKrXn2uS0N3Wfm/cLydJfeTX2vSIvxihMRrivu9Hjr0mC+4EqBBj09XRW/kh9mMTbtQMJx6Tb398yDrqvDCPiW1VFBdhEMh9RN8fIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kefXSW/XWiuqSXAZyOrCbwsmCOm4Cs/eQw1Odk1bPGk=;
 b=E5gH3Lap4ehnEEx2ha9DhSiC6iEjMSDy9IF5tg09dZnrUkLcxeYH4cOsImP1WVok/njdhOAgWs8m/MQTVXnc3gUTnf9uTwyh93KUhAhSq7Ew8utR0XZIx67TR7jq/bVr24x+sF2gr9Y83KyU7d626rP0+FruIy4xDicyb5o9XSNWR3nwXPqRpVbpiI6tdT2znqRz2Rphyo+givEx3Coo8cZ7Zhgr04Z1AxfgfiKt2pKK+B+/65BsWX1dHKT4IJ0vRJKiuosLx4XLSgZdFWY+M8Pwd8amKh4FldY436Wm0SoRmfTrYPhDEl7QPQadN0w0Q8Y2PGETA5dB9r9LYM8a4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kefXSW/XWiuqSXAZyOrCbwsmCOm4Cs/eQw1Odk1bPGk=;
 b=KRJq+h+IoqXySWVjGVGGsmUGbO9gmNemeq32lq199mTV65ucxPsk/ahM29LcPmvSrFVGsT3P8tYlBMHX97klZRIH6TCuPBj3n675C0QgXlV3297/z/Y/eAAI9I4epNfJSFUtrSMN0YYw/yHYIL7rpb7dMapts9y9gbUxxDUmFgI=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LOBP265MB8897.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:490::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:49:05 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:49:04 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: Add job type info to
 pvr_job_submit_fw trace event
Thread-Topic: [PATCH v2] drm/imagination: Add job type info to
 pvr_job_submit_fw trace event
Thread-Index: AQHdRyX0vIgvKNRqUkuUis/rWPrOJrbT9gyA
Date: Fri, 18 Sep 2026 07:49:04 +0000
Message-ID: <e463782035ff8ed01ebb3d2e5cce94f98a35d470.camel@imgtec.com>
References: <20260918-b4-submitjob_tracepoint-v2-1-d9b104de07b8@imgtec.com>
In-Reply-To: <20260918-b4-submitjob_tracepoint-v2-1-d9b104de07b8@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LOBP265MB8897:EE_
x-ms-office365-filtering-correlation-id: e61c15ed-b7b7-496c-e4e3-08df15594fd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|22082099003|18002099003|10067099003|56012099006;
x-microsoft-antispam-message-info: an4wP3R0hoYI5f80xeWLYss28iu4nB1kssrO4ZCBwkSQK2YSIVs9G+gimtF6RflSQThqo+ctvW+w71JMNxXQNKLHltMGYb7aTwYbHLeiDiuk2BNAkeoiikPZWJqZV7bApXB34khT/mtIeAwva1hJ5Sf6fEtKfRg8bde8/jReYT3K0CuFVIPkVezFQjNETv6WRi1ovJ8SG2i0aFbOz+27LuUNGHe7E1jX8POmmDBj4nQJ+AYbSIoCwbzyVttGzJfBFwfUmRN/2J/capNydCdci+7HBieqmXFN0DANi1aeLxRecNSGgyrVZ/fqHYpWU+LoSZaed5/IWiprtPNBSdMyohyFqs96OcjZclOBBWaYnfCWZ0cbkMXvWcDySlTlaNoEJutrjhfTa3lg7rqqcbYDo13OKUjR//ZBY/RoUg9hpZtQd+ZBN1HeYMrDzr7qwcbdwshEUa4ZHKtHzVlbFZ1nVn+EHHWlgY2nev5rC5j/Zb4PFS4VILYJy+YMILC2Ml/nLejFuc1Qer7RyiJYAgPM2+Cr4xZBWv+x19d3mILs4lH3RBmu+eQY9v7AGDSCMPSpVQYjTTzuvp0NlmB/BIe+cdYNGtWSrt+ciw42n7yRfa4Jcfz2k+wnKhQIWvXKqgSqOceidpy+vB7Xt0Xn3xqJ0x+NtkNL6BVsQXXpT2VEF5rfgJ1SZjrK3o6VjhPHAdLNlVBjnq3s+JA9rpnZ0jIYPe+vDWZEsVDiarvvSAzEkeo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUtXQnBWVjBhVGxDVHpIcVJFU0FxdUFscFlMdkZ5ZHcvRHpEQXB5eFNadUs0?=
 =?utf-8?B?UW44N0JBc0d0YVhmbDFWY3RodDNFMmlseEJyOFdMRFNtT0VlQ0pINzVNUUhm?=
 =?utf-8?B?eWNnVTAvVno1VFJlckdFaWtMaEloMFI4eTlQMXdmVHJXeXM5Nk1sYkdTZFF5?=
 =?utf-8?B?UDZBa05rY2hFYmVIeFFhQy9IK3oyejI3M3R6UGhQN3ZvbTRLb054Z29rTEtj?=
 =?utf-8?B?UUVTd0VKZE9yRjV5RUFHM0hQYlBXY3BGN3pRNHFTVnQrM1U2VTlUT0Jmazgv?=
 =?utf-8?B?dkZkRGRqRUk3bEtVd2xadFh1NWNKOE9Gb2wvaXUwc3RtUkRmcGl1ZVBNb0I4?=
 =?utf-8?B?Y3V0Q3E4NlRpVUlXQVBlUmJrVm8va3BpQVAzbDFZcHovOHh1MnBuSVVWYklL?=
 =?utf-8?B?TGJxOTlSZlYxVlVJUHV4T0NFM01EN21iZ1JoRDVwZHRnem5vKzhoQ0dIUFVI?=
 =?utf-8?B?b1llMFg0NWNrQlhKV0YvK0JZaU5QaUlCQzh4RTJienFtbXRFbm15SVFreW8z?=
 =?utf-8?B?Yys4TzRRci9oTnFldFN2ci9CbnNINUJCbGNDNzZ0aHVSZzBnQUorNDJFbHNL?=
 =?utf-8?B?dmRiV291RTdOMHUvdThmQ1lVSW9TM1VEbit0WkxpbXgwYWRlanhKR0MxZ1JP?=
 =?utf-8?B?N2xJTU15SGxrMEpQMnFweVpFNnhJakpFRTdRdFVyU0JLamlELzFGSFRrSTBG?=
 =?utf-8?B?Rk1aN2ZDall1NHZTNUxWQThyTVlWNS9JUWdDeUliK20vMmpOdllWOEwzcnUz?=
 =?utf-8?B?NFAxSTBGSHM4bHNjSWtPMk5zSFc0M01KM0dBczJBS1M5TklTV3VxZFNkUVVW?=
 =?utf-8?B?c2xFUGJPNkRpUmVaSk5hK0VKTFVGbHBDdmtvL3NPbkVMTklxeENhcnNNTVpk?=
 =?utf-8?B?djc5NDgweGNmVStSTFNRVS9nVEJRN0FxbkNYOXNiVVdYaGttdnhnTzREYnhp?=
 =?utf-8?B?N09WNk9PNTRUSDIrZ1Z6WWRzNFZ0bkRFT0laMlVMMjd1TWN3ZUgyWEpiVjlq?=
 =?utf-8?B?ck5nQ2FKMVhJWUlTQzZSbWdIQzI1SmVGa2VVbW8rUnVTVWtTUGgrWUdQb0Ju?=
 =?utf-8?B?WDlHTThHVGlTRlNSNlFVMllTZkp0ai9pRmM1bHlpUTN6YkQ3TW1wSFBlRGdq?=
 =?utf-8?B?a2x0bld0SjErWFZtYjBYVTA1aHk2YjRuWXBXRzEzdFF0Wk5EcVhZV1lTWFBY?=
 =?utf-8?B?a2w2ZmpseHpRZXJ3SDI5dUh4SXROY1NHQUtKNElma3dUYkJhUkhjc1RRMU5u?=
 =?utf-8?B?Qk9tVGJ0dEJHNUM4L0Jjc2VNRDEzbnhlUHozOUdwcE55RDE1ZHZCTVpWK2Va?=
 =?utf-8?B?c1lBaUF3RGh6VytnTjEwSGpMZms2WnFJRG42VUxmOGVtVis1Vm8rNWxhdmlz?=
 =?utf-8?B?YXJ1dTFJT0hUeTNqWmRBUFZiazV3U29YNlFkU1BLemg4SW1sS01rNXpDcUk2?=
 =?utf-8?B?ZTdLSkRjM1h3bjB4UHNkcTB6RTFjMDkwem9la0gwRDZSSldocWM4cXFxSjRj?=
 =?utf-8?B?Rlp1am9mWHp1MWEveGZoQURlQWNSR0pjSVdFL2FNU0s0bjlFUGlWZWo2UUhJ?=
 =?utf-8?B?YURDTFJvTDlRcTI3T0x2V2xMR0ovZzBudjU3cWZ6WTBDZmpPQnkvaFRTbHdx?=
 =?utf-8?B?TUFvRjBaVHkrdkl1ZmdROGF6K2M4QjRKV3dSVVZHakpDQjVIR3hyZ0VoM3Qr?=
 =?utf-8?B?WkFOVWxPOVNob3dONTlkbThOWVBRckRtcnlqdW9sTHJBN2lKbXJiNHdWWFNs?=
 =?utf-8?B?TXBUYkRoMnRaWjMrWGd3TXYxc0wvY2tDK3BxU1ZnWTlTUjJicTdRMkdUQ1lu?=
 =?utf-8?B?YURnSmRGYW5DR0VnZW9NTU4rTU1VaEtQSVdHZ2l2WmFPOURCVkdxVDJJTHpV?=
 =?utf-8?B?N29QdlZDaytwcWJ4UE9sS01aeVUwckFyTCtLdW1DTFErWk5LYnA4eGFSRmVl?=
 =?utf-8?B?cGF5SE9RWHlVb212eitoYWxhYjcwTytiSi9uSHVucTg5ZXROclhJSjhQakVT?=
 =?utf-8?B?T2lFWTZlMUpaZldmMWxyQWJ6RTRLcXlTdm5JayswZmZQTHdOejgycCt0UENz?=
 =?utf-8?B?UGh3Y2pwZDhKTCtNb1ZoNmNVdHBJNytZTmU4VnZadndVY1hYRzdoYnQ3Nmpk?=
 =?utf-8?B?dU9VZkl5cDk0VjNGOUtHcXhNd09acUN0WWRGZ0J6UGdma25Dam9pUy9XcHR2?=
 =?utf-8?B?ckl3RWRZU3lwdXlzQlpoRXBObGM4VUlIdlJUeW9RdGFUemNpSUdNRFE4WlVo?=
 =?utf-8?B?QlpOeWVJeEgrMXVWdlhITHlKRCs3ZHdaUURMM0pxVUVOKzlUd1Q5eVlPM2tr?=
 =?utf-8?B?TEFpcG9nMWlFNmNjbndmWHZ2aEN1UFZDdExha3NibU5CZG1LcFkrOGFENzVZ?=
 =?utf-8?Q?DkpAEykTp0B4kUMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F001BBBDA26C54C89C821C85EA3893E@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y7zB8bzFlaiOFTEExTqpHP8xQbRFULyvVuM9Fjug9vquNb74cgouiiK4VtOEko4vAdVvy7Sf+ZBgsAlZ3mPL8l+rQfglm0yLWlEfONh4k9Fo2QuDl23QXa4IKC0psIMakkiOZd9mdp3U3mFj4ALE1uHh4cmUYmevzh3Pg8r/DyOAkMJ6lQyT+FWV4wk4Sxr/6IJ/TChMl/Lms2wXPpx1AaepcCkCKw3/nLaBmnThFlEIz4zc1+XnTq5eR5Ql+ZMsclxL0DuKar+Lw4aYjPqj6QWO9EPtUAjTcT6VSBX2XZKEWBKsCx30zU5upPftJlpQ08Facx95rGYliHV5NPpXLA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e61c15ed-b7b7-496c-e4e3-08df15594fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 07:49:04.5422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DN6RfgG+8RC4TGSA5R2KdH0WZe+GE4lS81PMwpFVYG9Amk/e/uBoFnIPIRe7UqQprzWm82p5xSaFmllmTkmFMHmNq1lcQw6lJI8VJsulT3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8897
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwNiBTYWx0ZWRfX9K2uzUdRGvBM
 sqwA+o2kA2c7c5HWF4XhEweSobXhG03rG0tYgMIwq9G3TWNEbXg0N8jw/62p5TYElZspspAmsU4
 ft21WbpuMltdpEA31CoAtS9UzYcD6+qV1S/fnbtdqbBwQRK2yVXYelAlhGkJ33rmRefqqH2iVnu
 nz2ueP8pgbbvima0U/A8zc3Y5XpZ5RSIS5AX3LZRpXxjDOHbqBnQMcpO0Ib8tJg8XCof3qoaPjW
 0IZNlRACKSAYoLh3ZzrNyhYJr+cNtVRz8JkOS1imp9qWagqwS6pRCacD0hGFVqtm9ppobq98pz+
 r8vGvwmCyUfO9V1eARm8+EWl8UI5Mft2wrlQCCHCah7RuZoEqUCwggp4L9YudI8yCcHtX0Sx95p
 w7JaozxJ/Dmv00oq+ao7gEcWsS+Qd4s4fM8XrN0oi05EambueZpJVE1bDnMi0ewZse4JgSFGbgM
 86d3H9n9IlzS/+cvYig==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aacecf5 cx=c_pps
 a=yq669X33ncfqIUuGGjZPqw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=Zbrq-qwaGSd7SQ6L89AA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: hxcBAz1GtiaCGxRsBrP-NfVBDs8b8BKM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwNiBTYWx0ZWRfXw/wkPhzPmnEU
 NTRMs8387ztlQJYwPgfbb91yacg7oYK+1qw1mbDzVv77mfBTZK2hm61893vEtzxg4qMf7R4FeL+
 6I+fndDJN/ckqqmyP3ERuDJexKjmb1I=
X-Proofpoint-GUID: hxcBAz1GtiaCGxRsBrP-NfVBDs8b8BKM
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

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA5OjU2ICswNTMwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOgpI
ZWxsbyBCcmFqZXNoLAo+ICoqKiBOT1RFOiBUaGlzIGlzIGFuIGludGVybmFsIGVtYWlsIGZyb20g
SW1hZ2luYXRpb24gVGVjaG5vbG9naWVzICoqKgo+IAo+IAo+IAo+IAo+IFVwZGF0ZSB0cmFjZSBl
dmVudCBwdnJfam9iX3N1Ym1pdF9mdyB0byBhZGRpdGlvbmFsbHkgY2FwdHVyZSBhbmQKPiBkaXNw
bGF5Cj4gdHlwZSBvZiB0aGUgc3VibWl0dGVkIGpvYiB0byBlYXNpbHkgbWFwIGV2ZW50cyBhcyBw
ZXIgdHlwZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRh
QGltZ3RlYy5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVA
aW1ndGVjLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+IC0gVXBkYXRlZCB0byBsYXRlc3Qg
ZHJtLW1pc2MtbmV4dCB0byByZXNvbHZlIGEgY29uZmxpY3QgYXMgcG9pbnRlZAo+IG91dCBieSBB
bGVzc2lvLgo+IC0gTGluayB0byB2MToKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYw
ODE5LWI0LXN1Ym1pdGpvYl90cmFjZXBvaW50LXYxLTEtZjgxN2IyMjJiZjZhQGltZ3RlYy5jb20K
PiAtLS0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdHJhY2UuaCB8IDE0ICsr
KysrKysrKy0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X3RyYWNlLmgKPiBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdHJhY2UuaAo+IGlu
ZGV4IDk0M2Q2YjI0MThjYi4uNGJlN2Q0YjhhMzU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9pbWFnaW5hdGlvbi9wdnJfdHJhY2UuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFn
aW5hdGlvbi9wdnJfdHJhY2UuaAo+IEBAIC05MCwyMSArOTAsMjUgQEAgVFJBQ0VfRVZFTlQocHZy
X2pvYl9jcmVhdGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IF9fZW50cnktPnN5bmNfb3BfY291bnQpCj4gwqApOwo+IAo+IC0jdW5kZWYgUFZSX0pPQl9UWVBF
X1RPX1NUUgo+IMKgI3VuZGVmIFBWUl9KT0JfR0VUX0hXUlRfRldfQUREUgo+IAo+IMKgVFJBQ0Vf
RVZFTlQocHZyX2pvYl9zdWJtaXRfZncsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUUF9QUk9U
TyhzdHJ1Y3QgcHZyX2pvYiAqam9iKSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRQX0FSR1Mo
am9iKSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRQX1NUUlVDVF9fZW50cnkoX19maWVsZChz
dHJ1Y3QgcHZyX2pvYiAqLCBqb2IpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHUzMiwgZG9uZV9zZXFubykpLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19maWVs
ZCh1MzIsIGRvbmVfc2Vxbm8pCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKGVudW0gZHJtX3B2cl9qb2JfdHlwZSwKPiBqb2Jf
dHlwZSkpLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFBfZmFzdF9hc3NpZ24oX19lbnRyeS0+
am9iID0gam9iOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBfX2VudHJ5LT5kb25lX3NlcW5vID0gam9iLT5kb25lX2ZlbmNlLQo+ID5zZXFubzsp
LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBUUF9wcmludGsoImpvYj0lcCBkb25lX3NlcW5vPSV1
IiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
X19lbnRyeS0+ZG9uZV9zZXFubyA9IGpvYi0+ZG9uZV9mZW5jZS0KPiA+c2Vxbm87Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZW50cnktPmpv
Yl90eXBlID0gam9iLT50eXBlOyksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIFRQX3ByaW50aygi
am9iPSVwIGRvbmVfc2Vxbm89JXUgam9iX3R5cGU9JXMiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5qb2IsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19lbnRyeS0+ZG9uZV9zZXFubykKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5kb25lX3NlcW5vLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBWUl9KT0JfVFlQRV9UT19T
VFIoX19lbnRyeS0+am9iX3R5cGUpKQo+IMKgKTsKPiAKPiArI3VuZGVmIFBWUl9KT0JfVFlQRV9U
T19TVFIKPiArCj4gwqBUUkFDRV9FVkVOVChwdnJfam9iX2RvbmUsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBUUF9QUk9UTyhzdHJ1Y3QgcHZyX2pvYiAqam9iKSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFRQX0FSR1Moam9iKSwKPiAKPiAtLS0KPiBiYXNlLWNvbW1pdDogYThmZTRlMTYyYmE4
MjEyYjdlNTFmZGIwMjRiMzc4MDBmMzZiNDk2Ywo+IGNoYW5nZS1pZDogMjAyNjA4MTktYjQtc3Vi
bWl0am9iX3RyYWNlcG9pbnQtZDM3NGYwNjUzNDVlCj4gCj4gQmVzdCByZWdhcmRzLAo+IC0tCj4g
QnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPgo+IAoKUmV2aWV3ZWQgYnk6
IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPgoKVGhhbmtzLApBbGV4
YW5kcnUgRGFkdQo=
