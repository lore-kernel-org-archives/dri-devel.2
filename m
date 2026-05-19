Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E6CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2962A10EB61;
	Tue, 19 May 2026 08:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="FBwQFC2j";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="deYtEUdR";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C972E10EB14
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:35:51 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5DWep3676857; Tue, 19 May 2026 09:35:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=4ECS9A4BblVottflUclhlxrfiNB7NZV2qZhMO3WkFT8=; b=FBw
 QFC2jaByrKO7EJLBz/4fknmtKMkdG0Dzmb8n+qJq1pn3y5nhQktRAU4BVGfG69DG
 w2iufcMeChxW7aqR6j6jO8Kn0dPYxWUNOb732rJlVp3XbexNlTOASOPDZv9xVKqM
 hcH0bwlPWGvzelC0PjA6GytkPz2/vqCFwOVFJJNgpIo4H4UPXyg7rgQACSQCQDqm
 zkNYfOhE5PpY8i/KRuBWfOKa1E3cZFUYWjs03DPJ4VTXkblP7brRaZIzDyu6IeVS
 LS2SfRPtro8/pJHvn7xaUL7dHy61ZkkOvQt/GoWNPf/01Z0MkOKSww1HYtKrOwGO
 MC4nUTFntJT5Y8lvKUg==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021143.outbound.protection.outlook.com [52.101.95.143])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjdk5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:35:39 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4UoeMBSexFtUCn7ivgIxKXWa+Wbr9qBTuiDOxU6gRZs3CYQJ8OjbRvR6WC8akVZB/ucLmD86iBRXASsN6cCenEQXWAd/oUC7dKyMUYO4tzqwFevkoQLb6Ckgo1iwj2B+ia31PnLuQwUJcud4MQF/NVVoORpgcrALksN/qYcPP7VNQyMJyd8of7rouqTNtAe1+hl8ab/mQZzwaejxresmyM8H5h3hBa7uOlJbPSirjR+omZGicdC6qnJFqgzg6Xn2huH7xPa4HlFpVV5i9tnj5qYd4RXeOoO/WCIxBZUQs8/dOTeUvwOjWWRP21Rrb5iY4Jkk03b+WpFCOhxf+LcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ECS9A4BblVottflUclhlxrfiNB7NZV2qZhMO3WkFT8=;
 b=oBU8lwsUrAN1u6ubpfxYdSBYenhXrEl2m0/hg30NGkuD9nhvTAtJLrAUfWQgUvllc9HyrDHgtUTaPbnEqnXDUkuwrZc63O/1UhW+OFGv0FPfcuGgsW5gkMn/yf9IX76FnPauvVld0E/CfMcEseNLUOnOFvvIIIDZE315edz1xQHvFu7d4KA3NEcsSQdYDwuB1zS2rMarQ5nBEA1a7TgrpcxiI5mXeFe2TlWRxbbSzLxZyWqedfqTeteMa+FJ8GRfwYspFb2y71peRL7gzC9qsQWelQKFv7WuxQllBqqF9NX5UGVYPt0dFkiXfmZhAkQJp6bgFeF200GoOuJreOeJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ECS9A4BblVottflUclhlxrfiNB7NZV2qZhMO3WkFT8=;
 b=deYtEUdR7VG1e6QYEZdO5FBXbeIYIa1mu3A+SAD8Tm8Ax0aOrDdxf4BL7vvgcNBwKWJgynJSulLCk3D4l5YLd/Vg8ro271h/aCpspa3wEtAP+c2n4mpGUszrHKtI+uvGDzFuh6oFRcER7JnQMBo+TnUcZ9vhaRq0VPWjLA4NBfU=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO8P265MB7965.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 08:35:36 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 08:35:36 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/imagination: Access FW initialised state with
 READ/WRITE_ONCE
Thread-Topic: [PATCH 4/4] drm/imagination: Access FW initialised state with
 READ/WRITE_ONCE
Thread-Index: AQHc4ds789M7wuHFeEyRqueIWvBcqLYT6tcAgAEmSgA=
Date: Tue, 19 May 2026 08:35:36 +0000
Message-ID: <5d92980cc2708e7956958f3bda95a233bdce23b7.camel@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-4-439bee96ed83@imgtec.com>
 <227b75a0-7e73-4344-bdbd-72834ee29fab@imgtec.com>
In-Reply-To: <227b75a0-7e73-4344-bdbd-72834ee29fab@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO8P265MB7965:EE_
x-ms-office365-filtering-correlation-id: 5b855889-8dc0-437d-97cc-08deb5819978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: vwb9mej174VTG2jA5MvAX4zKCkYIpYoo83WXazdwlSpyhl+9QjWdS0aOLViiarOabwyvbjNBkmEiCE8/b8Un8otF0MkkiExh9eZFbqgq7AjWGB58zUwBFnRs/bKozt4Qx82r3+OO+628cA8f0lh5TGDdykIPMizNaSRZdWLl49CHYY1CQS8472c3HvtWKT1J9BL0XiOyYdT29IuaOToWgZczypnKaez6mZ7zZ6SZeXvKUwbRdFVC1d0ChyO6y/w2zco1hI+2BJHYr9sZbve88qR1weV1A1IKCAI8TfMgWWpJUj3zvbIrT4zc6sAoa7ARF8zKxpeUWt85dffw58SiVJXbrncjSpfkrqqC6ABj0MBXBKHDZT1BfAhi/9jALnAevw7u69Z/XDZw+eVsrYnQB4FFXzeDrEVhvVourJJf60GaKJwY7Ovf7EOlev1RP2DQiysBghVTN/LG/HXdRmXvKgK3eoyoJTmH3GEacR7tgeqkQp9FolkphREb2+WX/tcn+qgL26VmzrCpNqerCQ3PQXA+bgDdMYxpFmi/dkwJlhgL4gPhNUO9FuT4zd9unB1O6LcasQygnCQPgPucehsGEuterIH3nG+csN9o21/0AZsHhkW19a+E+UhZ7V12vYumZx5EOUt6kKSDgdkvmXpyYn6BSsxzr4MqHEef6T4mp13HHuc+5l5a5uNRFfEiGC38dYI/t6ucv/JtngrLEe1uBDqsFqyza97TgMFdmkqoPEte02zGc2doIx8C6EiKdviQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVHRFd5YVMzWWxNZGJoUlpMS0E4Q3pJU0Mwc0gxS1dGd2NodkRvazZrbnUx?=
 =?utf-8?B?NUI2R1JSc01lTWVTL1p0SitFemM0b0x0VnE4OFR0K3QwbUc4ZzhYSUZrMDA0?=
 =?utf-8?B?ZndRN21XZ1pNNFNpZ3lwVSs1WUlaMnVjRGNzQ1BTWFgzMHZzb0R5dlZmOVk4?=
 =?utf-8?B?V09IVldwN3paTWNLQ09vYnpQN0FydUx3Q3JnZmJiYkZ4NVZmU3lGWTZtS3J1?=
 =?utf-8?B?RWtrZFdIaFJyU25PR3YzaFplbnV2aW1sR3hCQXRFMWFYU2toSUhsTVpKOEZn?=
 =?utf-8?B?RTNONlBmWjQvQlFqcWtxemVhTXo1M0tCQWw3NE5sa2VVUnRSVm5zNEN3SkhL?=
 =?utf-8?B?ZXZDeXd0d3Q3YWZpQXcwMGV2TmlPY1RNc2p3enFBTGpYNmRybThNa0o3TUVT?=
 =?utf-8?B?Zlh4WUVsNEVMalpsU2R6c0RXeGMyMkpVU2xXTFI3RktrVUFOS0JNUGw3cStP?=
 =?utf-8?B?SHRFTVFoOTc1TFYwZkZ1Qmd4aUhldnFkeTQ2cWtTMFN0dC9aTEhWUkJ1TSsy?=
 =?utf-8?B?VGpxaU9rblNkb3pRY0dZNGZkd2JRRnd5VStYZEEzSTJYd1J4VmJlN2JYWjV2?=
 =?utf-8?B?eWNoR280Q29RcjM5RjlRV3pjRXhEQzdLS3MrU0VtOTRlVnN0WU9INjQrNk1Z?=
 =?utf-8?B?eFc4YTlCaEFzVVB3TS81S1hJNDV4YmxnSkE1WjBtRGRyKzBwY1d1bEZCemRL?=
 =?utf-8?B?b2pHdThqRmFqK1gxUTFIendtWmJQdnVFWnQ2TER0QVo5eTY3KzlMMUVQNTQy?=
 =?utf-8?B?WVhCTG5veG9ST3NjQU1OOVBEU3NuZEtRc1FzLytRSEZsamkyYU8rZU1Yd01B?=
 =?utf-8?B?cTRCenJvVFRoRWlVQ3ExTXhTRHV1YzkvUnJKSnJEdUxsYk0yWUE2WUczRUVm?=
 =?utf-8?B?dmdETzVxOUpTdTRrTFRFZk1oKzdNbGFMWDZWMTdUMkFxYXZvMEpQMFFldXpT?=
 =?utf-8?B?YWlQWTVTdVd2a3Qrenh6Y0t4WnFYK3FUVmRENnpTeHZNb0c3bjhaOUJSTTg4?=
 =?utf-8?B?ZjhNWEN4TnE5a0svZ3h1eTNiZ2xIYjM2Sm1yWTVBcEU5S0pXNUwxam5LWThF?=
 =?utf-8?B?dFczcUdKcEUybFFrakd6V0FhMzRTVTI0c2RVNTVsaDJ3bU9SNDgra0F0UkpU?=
 =?utf-8?B?K0NXUDJvUjB5VzRLbXY1dlBETnljNjdaNGpKQkRNTGZGMHM5d1lPSVpsRUlT?=
 =?utf-8?B?N2RjV3Z6RUFJU3hVTWpFWnlGUmNDRUExVUYxVEhVRVVYZHJLL2tLWkErNGY3?=
 =?utf-8?B?REtlTU5aUStHeWR6WjM4Ti9aOGZtOHIrYnNSckdzS2k3UkNwcnAxZlBNN2Ur?=
 =?utf-8?B?TnBzU0ZRU0Via0NjdWJxemUyMkV2a08xR2ZvZVhKUzZmSW5pMDUwVWVEc1Iz?=
 =?utf-8?B?ZHNtRWRUbG9HVEpRb0VUakltY24weFpua3Q3byt2WXVZNEhSUmFWblc5Umsy?=
 =?utf-8?B?bExBbCtxWmIwbWF0TVVzTUFUWFdVdHFyUnk0UXpDTkd6Wk9tQnplMmg4cTcz?=
 =?utf-8?B?ZVpLM2hnLzE1WFB2MUZCZ003VXFPa3hVdmsxOUY5SURWRndMS21YdGV5blJX?=
 =?utf-8?B?R0NZbmZERWdYTWgvUWJNMEp1RUc2anQ0VVI4T3MxblpadHlueVg3S2pPSHZ3?=
 =?utf-8?B?cG9CSHcwN211M1V5MlRnanhLZWZnSVpiNFpka2U4ZDVlaGV5NW5WN2orRHUz?=
 =?utf-8?B?c043amlCbjRRUlUyQmgvVEx3THZTcUJNUlZrNEozSk9jU1VpVW1sdW5INVA1?=
 =?utf-8?B?aSt2SkZRYlEwaVRpRm5FS3pST0RoWmo4TGM3UGFaaVh3aUNUVnVtVXQ2emNi?=
 =?utf-8?B?d2h2dDh2ZGc1elBsRWtVZGszVENlQ1g5R2dtaFlKWEdYa0hpWXVtcFU0eXFF?=
 =?utf-8?B?L0pnbURYNzhMTExVbmtmcXhBeDZ6UFAvbkQ0bkJ2dXBUL3RncENpeTJKZ1BU?=
 =?utf-8?B?THJSRXBOakpMSnA4Mittb0hRaXB0U3JxUEs2RlZCSFVyajBIbjFMd1FlZCtF?=
 =?utf-8?B?dENlNVBaWXo2K1dBeWpld05tZE1lbXpzcjNjZ3BMTSs0SE5hYWNiV3lERC92?=
 =?utf-8?B?ZFVma0w4L1RWZ0x4b1NBck00U2t1Mms2bFZMZGRXSStBSytyL0s1Ujl0bnQ2?=
 =?utf-8?B?TmlIYWtCYkk1TVpOd2dJYXh2RnBORUpUSWNIRGN5azdtL0NNWEMwdXhvczhD?=
 =?utf-8?B?TklPWnVRb1pjcHRDTUdjTitoekowNTBjZVlTOTROMlJ0Zk1iN3pyVzNVVFVM?=
 =?utf-8?B?RUJaNU93U2MwdkVGaHpZV0crdW9JUUs0MGtoZFpYcWtoZkJXT0RMMm90K282?=
 =?utf-8?B?ZVZXbGVGaTZrS0ZWTy82aC9MRTA0RENuUlM4cW1pazFFcVR6bGp0eFNrS3V4?=
 =?utf-8?Q?g3wLLLxTBZXk7NeA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D44D4D50EDE0C4F9C02B3ED6ADA1417@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5YgwTMfGNK4Uuhh2dtVSq9a5vVUPYl0Pd1dZADqOFiN/ocuzRuiMXD7VirjSAll10NLTP1rDWRFvup8Dm/BJdtNzXv8vnzDVh3vztfhB5RYNTpArXTqp5Mmzpg8JOaCFlqlJlqMeLTIehoc6RyeHPWRjdxdzIgHATUpKEfhC/W9hVDC2pVVeqvNqwQBqLlpFvfEkaNhWyY8//kfyfQ68gMURHd9fd2/9CcsemB15FSGhhcdOrRH+rrKFvUWe532VnaPwsKEVxLAnuj4MS47T6uJhnADUcEsMPpiL7U3KBGn2g8uH6bIKvnl3wwYNxB8KWRFnm4iMMlhmRrVxadLxA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b855889-8dc0-437d-97cc-08deb5819978
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 08:35:36.3131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/gR+dJrof+JiT/lWJVb1LRJG4X6nDsqXvcXSaVtDtTJTNNBJfdQ6yMlvIcU79iN5xfbsZBaLRpfKzYPdN8v7uLDPx21WIm0A8CIrLbgdBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7965
X-Proofpoint-GUID: rn7V7K008zyK0L0VUqm0x47IdEqw-1Rc
X-Proofpoint-ORIG-GUID: rn7V7K008zyK0L0VUqm0x47IdEqw-1Rc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NCBTYWx0ZWRfX6XSl9Kql7u4c
 LVuFJ8Iyx7DKr1cPeCBkISyZZi51R1kilxpTbKlmGDcEYIPQNOSw7rkZDlT5PEM/0850He/FEKi
 qKW9R4pKnvpNvGU/k9M8Srd51teT4g0lwfY+QrKUwRKG4bd5eR0M8xNWKNwBElM0kKNEpDg3CRx
 CrGaQH5ZoIegoOx9AjBiy5JjgJO/avDIjItFL7BiU7sotzXc2HsqZlysT4oePjm/iVkvHn8+Mkd
 ABocotpXZnUnibshQrJ3mO/pffOM4+Ega5C6tkZsIq58a313kJXSMcXVlp57ErTJdu0avvKR261
 SrB/jclkao0ty974EhYjfJk6r9BoEPzkReog+JmPDdvJNsKuvNZJ8iFjpLCzBO+sPoY+FXXd8AJ
 aib6AasxI8diIO1hOqaJsvvbPWqHbsnJ1PdEERDTmgg+/XqeoK2KT+eHK7wzPFKKh0T1i0gLsxE
 Q1b4OC/ziVL1x3ax5Sw==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c20db cx=c_pps
 a=aGDofOi8WJPiWJRw30jVnQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=KNAE8Rij2h7GYe2hvLcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDE1OjAyICswMDAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
SGkgQnJhamVzaCwNCj4gDQo+IE9uIDEyLzA1LzIwMjYgMDc6NDcsIEJyYWplc2ggR3VwdGEgd3Jv
dGU6DQo+ID4gVXBkYXRlIEZXIGluaXRpYWxpc2VkIHN0YXRlIHNoYXJlZCByZXNvdXJjZSBhY2Nl
c3Mgd2l0aCBSRUFEL1dSSVRFX09OQ0UNCj4gPiB0byBwcmV2ZW50IGFueSBjb21wbGllciBvcHRp
bWl6YXRpb24gYW5kIGVuc3VyZSBhdG9taWNpdHkgb2Ygb3BlcmF0aW9uLg0KPiANCj4gV2UncmUg
bm90IHRyeWluZyB0byBwcmV2ZW50IF9hbnlfIGNvbXBpbGVyIG9wdGltaXNhdGlvbnMsIHRoZXJl
IGFyZQ0KPiBzcGVjaWZpYyBvbmVzIHRoYXQgUkVBRF9PTkNFKCkgcHJldmVudHMuIENhbiB5b3Ug
cGxlYXNlIGluY2x1ZGUgYW4NCj4gZXhwbGFuYXRpb24gb2YgZXhhY3RseSB3aGF0IHdlJ3JlIHRy
eWluZyB0byBhdm9pZCBoZXJlIHNvIGZ1dHVyZSByZWFkZXJzDQo+IGNhbiB1bmRlcnN0YW5kIHRo
ZSBtb3RpdmF0aW9uIG9mIHRoaXMgY2hhbmdlPw0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IChmb3IgaW5zdGFuY2UgaW4gb25lIGNhc2UpIGl0J3MgdG8gcHJldmVudCB0aGUNCj4gY29t
cGlsZXIgZnJvbSBhc3N1bWluZyBpdCBvbmx5IG5lZWRzIHRvIHJlYWQgdGhlIHZhbHVlIG9mDQo+
IGZ3X2Rldi0+aW5pdGlhbGlzZWQgb25jZSBvdXRzaWRlIHRoZSBsb29wIGluc3RlYWQgb2Ygb24g
ZXZlcnkgaXRlcmF0aW9uDQo+IChncmVwICJtZXJnZSBzdWNjZXNzaXZlIGxvYWRzIiBpbiBbMV0g
Zm9yIGRldGFpbHMpLg0KPiANClVwZGF0ZWQuIFBsZWFzZSBjaGVjay4NCg0KPiBPbmUgZnVydGhl
ciB0aG91Z2h0IGFmdGVyIHNraW1taW5nWzFdOiBkbyB3ZSBhY3R1YWxseSBuZWVkIHRvIHVzZQ0K
PiBSRUFEL1dSSVRFX09OQ0UoKSBvbiBfZXZlcnlfIHJlYWQvd3JpdGUgb2YgLT5pbml0aWFsaXNl
ZD8gT3IgY2FuL3Nob3VsZA0KPiB3ZSBqdXN0IHVzZSBpdCBpbiBjcml0aWNhbCBjYXNlcyAobGlr
ZSB0aGUgbG9vcCBib2R5IGV4YW1wbGUgbWVudGlvbmVkDQo+IGFib3ZlKT8NCj4gDQpBZ3JlZSB0
aGF0IHdlIGRvbid0IG5lZWQgUkVBRC9XUklURV9PTkNFIGZvciBldmVyeSB1c2UgYnV0IGtlcHQg
aXQgdG8gbWFrZQ0Kc2hhcmVkIHZhcmlhYmxlIGFuZCBzeW5jaHJvbmlzYXRpb24gZXhwbGljaXQu
DQoNCj4gQ2hlZXJzLA0KPiBNYXR0DQo+IA0KPiBbMV06IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
ZG9jL2h0bWwvbGF0ZXN0L2NvcmUtYXBpL3dyYXBwZXJzL21lbW9yeS1iYXJyaWVycy5odG1sDQo+
IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3VwdGFA
aW1ndGVjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9kZXZpY2UuYyB8ICAyICstDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
ZncuYyAgICAgfCAgNCArKy0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
bW11LmMgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bv
d2VyLmMgIHwgMTAgKysrKystLS0tLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfZGV2aWNlLmMNCj4gPiBpbmRleCA0OTY5NjEwMWI1NDcuLjI2OTFlZjlhZjBjYSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2RldmljZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9kZXZpY2UuYw0KPiA+IEBA
IC0yMTMsNyArMjEzLDcgQEAgc3RhdGljIGlycXJldHVybl90IHB2cl9kZXZpY2VfaXJxX3RocmVh
ZF9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgICB3aGlsZSAocHZyX2Z3
X2lycV9wZW5kaW5nKHB2cl9kZXYpKSB7DQo+ID4gICAgICAgICAgICAgICAgIHB2cl9md19pcnFf
Y2xlYXIocHZyX2Rldik7DQo+ID4gDQo+ID4gLSAgICAgICAgICAgICAgIGlmIChwdnJfZGV2LT5m
d19kZXYuaW5pdGlhbGlzZWQpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKFJFQURfT05DRShw
dnJfZGV2LT5md19kZXYuaW5pdGlhbGlzZWQpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcHZyX2Z3Y2NiX3Byb2Nlc3MocHZyX2Rldik7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgcHZyX2tjY2Jfd2FrZV91cF93YWl0ZXJzKHB2cl9kZXYpOw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHB2cl9kZXZpY2VfcHJvY2Vzc19hY3RpdmVfcXVldWVzKHB2cl9kZXYpOw0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMgYi9kcml2
ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gPiBpbmRleCBiOGFkM2YxZDIyMmMu
Ljg1MGEzZWM4ZTc3NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX2Z3LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3
LmMNCj4gPiBAQCAtMTAwNCw3ICsxMDA0LDcgQEAgcHZyX2Z3X2luaXQoc3RydWN0IHB2cl9kZXZp
Y2UgKnB2cl9kZXYpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2Z3X3N0b3A7DQo+ID4g
ICAgICAgICB9DQo+ID4gDQo+ID4gLSAgICAgICBmd19kZXYtPmluaXRpYWxpc2VkID0gdHJ1ZTsN
Cj4gPiArICAgICAgIFdSSVRFX09OQ0UoZndfZGV2LT5pbml0aWFsaXNlZCwgdHJ1ZSk7DQo+ID4g
DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiANCj4gPiBAQCAtMTA0NCw3ICsxMDQ0LDcgQEAg
cHZyX2Z3X2Zpbmkoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYpDQo+ID4gIHsNCj4gPiAgICAg
ICAgIHN0cnVjdCBwdnJfZndfZGV2aWNlICpmd19kZXYgPSAmcHZyX2Rldi0+ZndfZGV2Ow0KPiA+
IA0KPiA+IC0gICAgICAgZndfZGV2LT5pbml0aWFsaXNlZCA9IGZhbHNlOw0KPiA+ICsgICAgICAg
V1JJVEVfT05DRShmd19kZXYtPmluaXRpYWxpc2VkLCBmYWxzZSk7DQo+ID4gDQo+ID4gICAgICAg
ICBwdnJfZndfZGVzdHJveV9zdHJ1Y3R1cmVzKHB2cl9kZXYpOw0KPiA+ICAgICAgICAgcHZyX2Z3
X29iamVjdF91bm1hcF9hbmRfZGVzdHJveShwdnJfZGV2LT5rY2NiLnJ0bl9vYmopOw0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiA+IGluZGV4IGU5ZmVmY2M0ZTIzNC4u
M2NhYzQ4MmUxMDM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21t
dS5jDQo+ID4gQEAgLTEzNCw3ICsxMzQsNyBAQCBpbnQgcHZyX21tdV9mbHVzaF9leGVjKHN0cnVj
dCBwdnJfZGV2aWNlICpwdnJfZGV2LCBib29sIHdhaXQpDQo+ID4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlPOw0KPiA+IA0KPiA+ICAgICAgICAgLyogQ2FuJ3QgZmx1c2ggTU1VIGlmIHRoZSBm
aXJtd2FyZSBoYXNuJ3QgYmVlbiBpbml0aWFsaXNlZCB5ZXQuICovDQo+ID4gLSAgICAgICBpZiAo
IXB2cl9kZXYtPmZ3X2Rldi5pbml0aWFsaXNlZCkNCj4gPiArICAgICAgIGlmICghUkVBRF9PTkNF
KHB2cl9kZXYtPmZ3X2Rldi5pbml0aWFsaXNlZCkpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX2RybV9kZXZfZXhpdDsNCj4gPiANCj4gPiAgICAgICAgIGNtZF9tbXVfY2FjaGVfZGF0YS0+
Y2FjaGVfZmxhZ3MgPQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX3Bvd2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMN
Cj4gPiBpbmRleCBhNzNhNjgxNTMwNmIuLjBlZDllN2JlNjA0YiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMNCj4gPiBAQCAtMjE2LDcgKzIxNiw3IEBA
IHB2cl93YXRjaGRvZ193b3JrZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICAgICAg
ICAgaWYgKHBtX3J1bnRpbWVfZ2V0X2lmX2luX3VzZShmcm9tX3B2cl9kZXZpY2UocHZyX2Rldikt
PmRldikgPD0gMCkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRfcmVxdWV1ZTsNCj4gPiAN
Cj4gPiAtICAgICAgIGlmICghcHZyX2Rldi0+ZndfZGV2LmluaXRpYWxpc2VkKQ0KPiA+ICsgICAg
ICAgaWYgKCFSRUFEX09OQ0UocHZyX2Rldi0+ZndfZGV2LmluaXRpYWxpc2VkKSkNCj4gPiAgICAg
ICAgICAgICAgICAgZ290byBvdXRfcG1fcnVudGltZV9wdXQ7DQo+ID4gDQo+ID4gICAgICAgICBz
dGFsbGVkID0gcHZyX3dhdGNoZG9nX2tjY2Jfc3RhbGxlZChwdnJfZGV2KTsNCj4gPiBAQCAtMzc4
LDcgKzM3OCw3IEBAIHB2cl9wb3dlcl9kZXZpY2Vfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ID4gICAgICAgICBpZiAoIWRybV9kZXZfZW50ZXIoZHJtX2RldiwgJmlkeCkpDQo+ID4gICAg
ICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiA+IA0KPiA+IC0gICAgICAgaWYgKHB2cl9kZXYt
PmZ3X2Rldi5pbml0aWFsaXNlZCkgew0KPiA+ICsgICAgICAgaWYgKFJFQURfT05DRShwdnJfZGV2
LT5md19kZXYuaW5pdGlhbGlzZWQpKSB7DQo+ID4gICAgICAgICAgICAgICAgIGVyciA9IHB2cl9w
b3dlcl9md19kaXNhYmxlKHB2cl9kZXYsIGZhbHNlKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYg
KGVycikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9kcm1fZGV2X2V4aXQ7
DQo+ID4gQEAgLTQwOCw3ICs0MDgsNyBAQCBwdnJfcG93ZXJfZGV2aWNlX3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICBpZiAoZXJyKQ0KPiA+ICAgICAgICAgICAgICAgICBn
b3RvIGVycl9kcm1fZGV2X2V4aXQ7DQo+ID4gDQo+ID4gLSAgICAgICBpZiAocHZyX2Rldi0+Zndf
ZGV2LmluaXRpYWxpc2VkKSB7DQo+ID4gKyAgICAgICBpZiAoUkVBRF9PTkNFKHB2cl9kZXYtPmZ3
X2Rldi5pbml0aWFsaXNlZCkpIHsNCj4gPiAgICAgICAgICAgICAgICAgZXJyID0gcHZyX3Bvd2Vy
X2Z3X2VuYWJsZShwdnJfZGV2KTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKGVycikNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9wb3dlcl9vZmY7DQo+ID4gQEAgLTU0OCw3
ICs1NDgsNyBAQCBwdnJfcG93ZXJfcmVzZXQoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsIGJv
b2wgaGFyZF9yZXNldCkNCj4gPiAgICAgICAgICAgICAgICAgZXJyID0gcHZyX3Bvd2VyX2Z3X2Rp
c2FibGUocHZyX2RldiwgaGFyZF9yZXNldCwgZmFsc2UpOw0KPiA+ICAgICAgICAgICAgICAgICBp
ZiAoIWVycikgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChoYXJkX3Jlc2V0KSB7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdnJfZGV2LT5md19kZXYuaW5p
dGlhbGlzZWQgPSBmYWxzZTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdS
SVRFX09OQ0UocHZyX2Rldi0+ZndfZGV2LmluaXRpYWxpc2VkLCBmYWxzZSk7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBXQVJOX09OKHB2cl9wb3dlcl9kZXZpY2Vfc3VzcGVu
ZChmcm9tX3B2cl9kZXZpY2UocHZyX2RldiktPmRldikpOw0KPiA+IA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZXJyID0gcHZyX2Z3X2hhcmRfcmVzZXQocHZyX2Rldik7DQo+
ID4gQEAgLTU1Niw3ICs1NTYsNyBAQCBwdnJfcG93ZXJfcmVzZXQoc3RydWN0IHB2cl9kZXZpY2Ug
KnB2cl9kZXYsIGJvb2wgaGFyZF9yZXNldCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBlcnJfZGV2aWNlX2xvc3Q7DQo+ID4gDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBwdnJfcG93ZXJfZGV2aWNlX3Jlc3VtZShmcm9t
X3B2cl9kZXZpY2UocHZyX2RldiktPmRldik7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwdnJfZGV2LT5md19kZXYuaW5pdGlhbGlzZWQgPSB0cnVlOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgV1JJVEVfT05DRShwdnJfZGV2LT5md19kZXYuaW5pdGlh
bGlzZWQsIHRydWUpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVy
cikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJf
ZGV2aWNlX2xvc3Q7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAN
Cj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+IA0KPiANCj4gDQoNCg==
