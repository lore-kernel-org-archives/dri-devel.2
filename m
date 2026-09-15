Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3801EC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DF110ECB0;
	Tue, 15 Sep 2026 16:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="BGZBoiod";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="JTuJHXBq";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C9910E8D4
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:10:13 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAivb4099122; Tue, 15 Sep 2026 17:10:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=TpdFtsxlXXLXZwW6/VjCFlx+NyavtQuqZfxVjxt7W90=; b=BGZ
 BoiodhkytClaf4O5xKHpIUdcizmxjR1e0U4lQ/EemVXb27V5ESH21IS/SzGjMid/
 c6wBq4odmnfQWieZF7OkC2iN3JH5oA4kTvCJIfWVAymrrwdG3icwpzvCTeMfjQQJ
 UtItfRL1ZFRt8YEbcUHxb4S1ngfYDVjgGYas4xZ4V5QyJUh1spzIs8/wT7DSd93Y
 FuGm9i1OC+7EwkHAD/Xo0MNouz5M27PLBw9pWHTS5i4/qomNgGP6G3JepktV/v6G
 q7UHr4hcEHVxT4Od8oTYDnFYVggpeH9geRZCHN0pe+HAJTdI6ZC1wyhBThdXxl2y
 yPsPUYg8cmdc78QbGPg==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021126.outbound.protection.outlook.com [52.101.95.126])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q2fj1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 17:10:03 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctq8ge5KWm6kI3UdIEMrmI+ugouPO8udNHbP+JImrU+vPjUQFDdGH7jCrCkfm5hGBQNxz+NlPh4+OwNDoJmDk9LTCBLj/NHWOSfSp569/VhX/RxSwnEXreiKO6hilHwVraiLtH63FlfOQydd1GrnVpRbyvme2BKtq3AFgdBXwkKGFazAKbnW0LM9hl2wKhBj7muvZFrPfVV0BSEn+6vfRoHBxdHMvZt0fNA57fT/uS3fPS0L1PX/8LYRb8LJB6w1HD8X5RPYt5pZFN2aVvZ7iivVZQHZ5b7owsmgD8WTZNYBwcPsS/MWHhiDr3IqiJpxwo4wP8PxlpEuir9fA3MA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpdFtsxlXXLXZwW6/VjCFlx+NyavtQuqZfxVjxt7W90=;
 b=pEk2H9jpoRRBXugNqhwqubtc0L53sBR96StFs9fzTZPCqeMX/Eith7ytzGY3M/rW2kX9xSug4bjt520UllfQVm7Ee1Bdc3SVlvRAvOqPJXYAGucgcu7btwL4yfxxNNCKRkT8flm+pGbbhc4Yp+MB/hzh4G5N4nGv8Ubg5VP7xPWPB1T1iAkAzs4IcI2yaJq/86wUKSGm58yhjqOe8OXdtPuO4f5rJ4WEfmuLgcwjGG8eKvF4B51ZwM+Lpk37PQZIW0OGZhGICMppWOuBaEGNIgqBI+x6DDJHFTP/KotxnqYTxF+itIB3oaqLKWD1te4QBanl/OChHpLYXb4FT1G27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpdFtsxlXXLXZwW6/VjCFlx+NyavtQuqZfxVjxt7W90=;
 b=JTuJHXBq+bGcums0Weeochg/ba3IK3xvSzS+lpcgTYa8kNe1OBaXldVUjzknfdTs2mJVemJPrCongmm84oYl2TXTLhZGXmtNc4z5uR73cFjaq+v6psD7rRAzyH49erJwBRaOqAg7v/xURpmQPEVCIYV9kdCX87aNBZLvPzPPsn8=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CWLP265MB6338.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:09:59 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 16:09:59 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "nm@ti.com" <nm@ti.com>, "a-christidis@ti.com" <a-christidis@ti.com>
CC: "rs@ti.com" <rs@ti.com>, "robh@kernel.org" <robh@kernel.org>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>, "kristo@kernel.org"
 <kristo@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "ssantosh@kernel.org" <ssantosh@kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "khilman@baylibre.com" <khilman@baylibre.com>
Subject: Re: [PATCH 0/5] drm/imagination: add support for
 j721e,j784s4,j722s,am62p
Thread-Topic: [PATCH 0/5] drm/imagination: add support for
 j721e,j784s4,j722s,am62p
Thread-Index: AQHcpbjZcOxk3AbdsUy91inPy2xfX7WSmh6AgT5zvwA=
Date: Tue, 15 Sep 2026 16:09:59 +0000
Message-ID: <0f68a788b7fa69a72e51feba765e0140c5c09934.camel@imgtec.com>
References: <20260224-gpu_dts-v1-0-cc5ddffe140c@ti.com>
 <20260225010507.flvt775fs5kfe7ez@unknotted>
In-Reply-To: <20260225010507.flvt775fs5kfe7ez@unknotted>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CWLP265MB6338:EE_
x-ms-office365-filtering-correlation-id: 10bd1d51-a949-4341-e8cb-08df1343ca7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: HZnmwCXH/C7sLoHAhg36u9RbFND+1doCmr3Sx9o66OZC8l64f6TkQqaVwl6beIfmPYKMWUtDq1R0xXQdubANvFtFqwLkUXWArjYIK4VwVcxMjLpWhyGFCmvza+Lj2ScVeRA9IlSw7fR38UErAaWquxN6wbgVG7S3fCJytkVBnstlTCrk5/wnpClpCaOoTcQqI9W9JGHZgS2xzQpVEDRUkiz6S98HZlKrcGioHMnkIwH84y4vI57ebR/CTeNu2NJ0khrFJu616GKA8C7WhJ+5hB5QdmKZXfCYlhivg+M9z/cw/vUsTLw6ndHbb0aWsSD4YZwKeNGi0vNH7i+sSF6aCxHdYmfNy9jDxvptmmeVyPDN9Wvn7DrlmVHOacm5h5xhKLi4N1SV5KWNEcntZrvKwZAwF3zMvBIEZ75spvv5/EipyERp5RhgLvgXFhZ2ji4qi9gtuZ7rfIPDWzl0YGIkcsjYHXbSF7qN1zyEZNGIFMwZUbG0Um5ftBXWhln32a8+uiuqHtz2w7upacty2tx/V2dvxCKfhdf0Jq6GwuAO+SLg6Go0PCp35qwLzORoKsHM36tXRyYiLiGeM4Hn4kr4QkfM0yGPXSJuav9cES7MPd+d/u3m1fHec4dQBnQzZsK2ltQCF/nOLYx6aQZQmw8MF5kXCASjYFXShyLaKnQzt0dm35vyuHdhJBsll058vTll9Z/RgQq0cHpr5aQESBgQl4tUJDguFJFkUbYtMSJjRd0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VKeCtBNkNvZitBZERtL3RaR0NFL0dTUmxPdVhxTVhNekFyWkd4QWczSjgw?=
 =?utf-8?B?ZUhCbURaZnpoOGxWYnF3QXVOR3RmYnVCblFWc2MwZUVTMXNSaXpiQ000WVho?=
 =?utf-8?B?QWlzS1FqdlROQ1A3V094N3ZOL0hkR0V1YXptYVNkeGMrdG04MjRoaGczSEVm?=
 =?utf-8?B?SGdjcmtPRVlEU1oyZWxSM1dMSEtVaHZhWDBreWNkd2loSm04a0NpY05ibFVW?=
 =?utf-8?B?R0xYcnJyUWhxemFkcnZtNkdFdmtQRE1YUkF6WmpNeDdhS1l6TlVLemFzZmt2?=
 =?utf-8?B?R2tGT3RGVHVoQTBGbTVoTjVnc1JwUG5uSVRod3dJenB5T1llbTNpei8vV2Iv?=
 =?utf-8?B?TnZIdzhQWTJOR2YzZWJpQjlDOWRKVngxaWJ4UEtaUkxkMFQ2RVBrZXBoYW5S?=
 =?utf-8?B?ZUJaZEN3ajhESFoxbHBTR0Y5V2F2K01xQXoxSEJoQzUwWlhGWlc1VjR0SkdL?=
 =?utf-8?B?Z3BHYU9yK1dUVHBtd1RSenZlb2lYcm5IcVd3bGhQL2RzdXNkVU11Wis0UlM1?=
 =?utf-8?B?UlNEZ1JzN0FFbFVaRlBnQmpGMVFJU3lqcXlIc0hMUDlHbVNEQUI3L3J5Z3RI?=
 =?utf-8?B?eGd0SmJPYUJYdys4VzRWWmFURVVqNk54U0xwelVMQXNxSllTTVA5YXlmajFi?=
 =?utf-8?B?Qi9ULzM0dzRLVlFyZlZOL0djWGFMUDFnYlZoREtzdlRvQm9lSFovSjE1akd6?=
 =?utf-8?B?eloyRmRabWFSczBwZDJFQlF0NmNBaVpzUVBaaVFLMTdIeEJqcWg2L1pMS3dD?=
 =?utf-8?B?MGRyVlZyeDRUVGh2cWhOV3lFaW8vemtxOUpkamo3dmM4eExvZ2RIalFFcUpV?=
 =?utf-8?B?SUtqWUY2bnQyWGs3dUZYNi9KL3ppWkdPZVhXM05ISGxqdXhJRXg5Tkt2SldR?=
 =?utf-8?B?V2gvVW1zMDJPT2YvSUJNRTlkby9SYVBnNUM1WHBXR0J4MzdLekVMYkpIbGN5?=
 =?utf-8?B?R2NuVm0zYlI4c0xDWDhTRXhvUWF1UkxpVjgyQU5WbFVzdW5PcjJRb3BpUmJZ?=
 =?utf-8?B?UHMxYXA5R2RHMkcxVVQzb0F0S3VHSy85TWhnSXh2bGRKR0g0YUJOaEFzMHBv?=
 =?utf-8?B?TEhkRXpnbC9FblpVUkozVnk3L25QUFBnMTFFamxZWi9raTRGbktQbDAwMEVH?=
 =?utf-8?B?Mm9ZTGoyTDFROFJoYTdkaHEyZ3JIVXB4UW96a1VMc2Faa1hLeTBoc2NSbXVY?=
 =?utf-8?B?Uk1pc3BtbjZSVmZKN0xQcUIwUm9TYTFsYU5pcThUUGFBNEZvNTZxM25vRE50?=
 =?utf-8?B?M1ltL1lTd0NKVzZHQW1GUkRKYkZORVp3c1BLYTZ5YnhRcGYzcDlFTzNZTTdK?=
 =?utf-8?B?cW5JSVlwTnhLeUdVdkVkc2hFaWtXQzFFR3Vvc2ZjRXBNNkdLNnVialVjc1c3?=
 =?utf-8?B?RGpRditYdjV5dDJmN2ZKajdKeUgvOEFlbnNaSG43UHd4eElrWjdHa0owNGNL?=
 =?utf-8?B?RVdvTk5UWFltZCtLTXRtMGVkb0V0V3V4OE9CQWNsdTdHc25xOVZxbm1pa1cw?=
 =?utf-8?B?K2I0cGVZalIySjBTZHBtRmM3OUowQWhYQkR0Z0toYTk4blB1SEY0cDRRY0JG?=
 =?utf-8?B?NFVpRG9WeFlGczNyQ1phWjJIVGUzVHVxSFMyRUUxY3MzcGJub2lSVWNVMVlC?=
 =?utf-8?B?ZkJXYUVoVmZ4bEZWMFU2cENUTzNvL3YzeGtPcmNFUkxKUk85ZXR0UEFlNTVD?=
 =?utf-8?B?Q0JsZkRRTFppZEZ2R3R2eGdWOFJCNWFscVhTZDNhV1V3U2gwVHFMTUJUWVp3?=
 =?utf-8?B?K2FLSldPN2YxZDVoNGx4K2Ftc2t0TXJheE9zYUErMGNHd2lwaUlINkhCNXFl?=
 =?utf-8?B?Y2JaVlNZeTVVK0RpSXB3UXhGQmRqSmsrOVRMUStDRm5aTzhJUDlldVllcGxo?=
 =?utf-8?B?blFiZEVQbFlGQ0h4dzRFUXpOVTlLWkllUGFHUkdIWHc0WXdkenR4RUZlbUw5?=
 =?utf-8?B?ZzhjQ3hHbStXVXpXNnBNWW1ocjNaeDh1TXN5cDFTSFdtUE1YaEhIc2xraWZw?=
 =?utf-8?B?SjZBc0RLTVh2aHZOZ3FYU1NFQmI3TFhzRGgweHBTZTE5M2tGL2dKSE5KMk0w?=
 =?utf-8?B?aEd3TzlnUkRrUTFPMDZ2UG9hVU9zdkcvc1FBV1VuaGtYcGR2SzlMb3hZS0NS?=
 =?utf-8?B?UmNMdXk0NU9WMStqdytLQkhDS2pZNGplMHpIWHRlNjhyRmxYU0F0K3lIWnFn?=
 =?utf-8?B?N25rTWF6Nk1YWEV2Y2l0bWNVdzgxMDRXVGN4WWdTeDk3b2xnbGE1RTF3bGhL?=
 =?utf-8?B?NzA1R3Q0SGxHOVY3ZUJ5RHFZYkd0djB2cEtDTTcxejRlUGx2QlNOQnFKbkRl?=
 =?utf-8?B?SWc4T3FmOFVRN2p6R085L3VtV05RWnZzVjhzWlFhRFZTVS9UeThpT2JUWTFD?=
 =?utf-8?Q?yfvkteLbw6XcoOVY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89B21520CD1DCB4DB0CD48EACCE50B6D@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y8bAh+1W8+sSWowTVdeTZExGVW8BVqXHlDQvQJjL+9z1GHqn7lBkt2yRID3+eAmRh+rIv9jhZSK3wndFTUHKaDZy0jArqbiZV1Rvl0BNod4yA/LoWPJhY8WtsMMAz/imaO4rj29b2ASiHb8udJbDN48npF5YC3l1NXjWoKpfbvrDIMG95FrJK7R98GLZMBDScbsHkSWshE+fKbqX/n4s03HuSDKkN1BLdGjsirYuXbHXgS2cAGglGne4Pzn2zzezQa+bBOArW5ly6lbMLGIo92Gzm3jc0QH6hLAGmA5mq25KYO6aJ3cvCeOlL5dy+/79oMSMBfYW9zxilf6oY8KPrQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bd1d51-a949-4341-e8cb-08df1343ca7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 16:09:59.0838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOPQIz8LK4ASdr1aba93wHqwebJOyklxbw+DlmEFjG2ki/ak+blTgNxhplOn+S5f/QE6ftFmxIMFSxbhqYlHNg4/ikoEK4s7kmOrDfwKJ8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6338
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzNSBTYWx0ZWRfX8tK929M1qa90
 kqiRYTJjQc1a4UINywMWQgj2czMEz8M9ixIwix9hHtOsCl9CA1kjCWQBoMteGZLFV7sZumLLpF3
 pDeWPXsaz5C0eAjia6NEcZMS5uqcsgPKWqh5Ufu+cnkgRb4FwtnX4OTfpXz8lIhQ2dA89/Mf1L8
 y94bVHumiz8/LoloGLa5a0xUfL6yB3f5XPpx/1hZRv8RTzD1MXdMQNdxuRm8vm1FsZaiT0Q+AMF
 f6H7Ku1FJzIhJzixYgyx36ak1YqVDX0g/N+vQBEGpCvMkZn5VqT2gJMeqDmimA8fnwkYzFysK5M
 XKs7a7ysX799perVfe4xUckrFhhKCKPYkeY2Cj5BZ6qK3VuLRYygcjcBYiyDIPaNhYtITI2HRSS
 O7qkPSc6u8UT0WHwC4Q6pIX9EhaNaSdo0ZG5FAjxzNjpSaTKNAWJ42+CjAonmQOEYRDqfTi1COf
 bVsk3LjqcAHaSn0JdkQ==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aa96ddb cx=c_pps
 a=7mkqjhPQrY6VIwGXKGjnRg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=sozttTNsAAAA:8
 a=yiAnzUoKtAspZWBFsgoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: olXxUrec9PjqLSOU1FZn06IL7gGTjFW7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzNSBTYWx0ZWRfX5x59atnudnw+
 n4YhL1SsAC0MVgs9qNESLWh8nUDoMjzhkQARVwibriG6zGI2jvjb0ajf28csCNfDXHH3bgobEBB
 ++i9CLCl0jb9eB0QM0KQpFX0o2h114Q=
X-Proofpoint-GUID: olXxUrec9PjqLSOU1FZn06IL7gGTjFW7
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

SGksDQoNCk9uIFR1ZSwgMjAyNi0wMi0yNCBhdCAxOTowNSAtMDYwMCwgTmlzaGFudGggTWVub24g
d3JvdGU6DQo+IE9uIDEyOjA5LTIwMjYwMjI0LCBBbnRvbmlvcyBDaHJpc3RpZGlzIHdyb3RlOg0K
PiA+IC0tLQ0KPiA+IEFudG9uaW9zIENocmlzdGlkaXMgKDMpOg0KPiA+ICAgICAgIGFybTY0OiBk
dHM6IHRpOiBrMy1qNzIxZTogQWRkIEdQVSBub2RlDQo+ID4gICAgICAgZHQtYmluZGluZ3M6IGdw
dTogaW1nOiBBZGQgSjcyMWUgU29DIHNwZWNpZmljIGNvbXBhdGlibGUNCj4gPiAgICAgICBhcm02
NDogZHRzOiB0aTogazMtajc4NHM0OiBBZGQgR1BVIG5vZGUNCj4gPiANCj4gPiBNaWNoYWVsIFdh
bGxlICgyKToNCj4gPiAgICAgICBhcm02NDogZHRzOiB0aTogYWRkIEdQVSBub2RlDQo+IE5vdyB0
aGF0IHlvdSBhcmUgcGlja2luZyB0aGlzIHVwLCBwbGVhc2UgRml4IHRoZSAkc3ViamVjdC4NCj4g
PiAgICAgICBjbGs6IGtleXN0b25lOiBkb24ndCBjYWNoZSBjbG9jayByYXRlDQo+IA0KPiANCj4g
QnVuY2ggb2YgaW50ZXJsZWF2ZWQgImtpbmQgb2YgcmVsYXRlZCIgcGF0Y2hlcyBpbiBhIHNpbmds
ZSBzZXJpZXMuDQo+IHBsZWFzZSBkbyBub3QgZG8gdGhpcy4NCj4gDQo+IGo3ODRzNCBjYW4gZ28g
aW4gb24gaXQncyBvd24uDQo+IA0KPiBqNzIycy9hbTYycCBuZWVkcyB0byB3YWl0IGZvciBjbGst
Y2FjaGUgcGF0Y2ggdG8gZ28gaW4sIGJ1dCB0aGUNCj4gY2xrLWNhY2hlIHBhdGNoIHByb2JhYmx5
IG5lZWRzIHRvIGJlIHN1Ym1pdHRlZCBpbmRpdmlkdWFsbHkgdG8gbGludXgtY2xrDQo+IG1haWxp
bmcgbGlzdCBmb3IgU3RlcGhlbiB0byBwaWNrIHVwLg0KDQpUaGUgY2xvY2sgY2FjaGUgcGF0Y2gg
aXMgaW4gNy4yIG5vdyAoYTgwYjMyYTE0MGM4KS4NCg0KSXMgdGhlcmUgYW55dGhpbmcgZWxzZSBi
bG9ja2luZyB0aGUgb3RoZXIgcGF0Y2ggZm9yIGo3MjJzL2FtNjJwPw0KDQpUaGFua3MsDQpBbGVz
c2lvDQoNCj4gDQo+IFBsZWFzZSBwcm92aWRlIHJlZmVyZW5jZSBpbiB0aGUgcGF0Y2ggZGlmZnN0
YXQgYXMgdG8gd2hlcmUgdGhlIHByZXZpb3VzDQo+IHZlcnNpb24gb2YgdGhlIHBhdGNoIGlzLg0K
PiANCj4gDQo+IEZpbmFsbHk6IGo3MjFlIC0gcGxlYXNlIGdldCB0aGUgYmluZGluZyBhY2NlcHRl
ZCB0aHJvdWdoIGRybSBtYWlsaW5nDQo+IGxpc3QsIHRoZW4gd2UgY2FuIHNlZSBhYm91dCB0aGUg
ZHRzLg0KPiANCj4gPiANCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2ltZyxwb3dl
cnZyLXJvZ3VlLnlhbWwgICAgICAgICB8ICA3ICsrKysrKy0NCj4gPiAgYXJjaC9hcm02NC9ib290
L2R0cy90aS9rMy1hbTYycC1qNzIycy1jb21tb24tbWFpbi5kdHNpICAgICB8IDExICsrKysrKysr
KysrDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtajcyMWUtbWFpbi5kdHNpICAgICAg
ICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRz
L3RpL2szLWo3ODRzNC1tYWluLmR0c2kgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKysrKysr
KysNCj4gPiAgZHJpdmVycy9jbGsva2V5c3RvbmUvc2NpLWNsay5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA4ICsrKysrKysrDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IC0tLQ0KPiA+IGJhc2UtY29tbWl0OiAzZWYwODhi
MGM1NzcyYTZmNzU2MzRlNTRhYTM0ZjVmYzBhMmMwNDFjDQo+ID4gY2hhbmdlLWlkOiAyMDI2MDIy
NC1ncHVfZHRzLWFiMzJjNTY4ZDc1Ng0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiAtLSAN
Cj4gPiBBbnRvbmlvcyBDaHJpc3RpZGlzIDxhLWNocmlzdGlkaXNAdGkuY29tPg0KPiA+IA0KPiAN
Cg0K
