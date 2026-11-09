Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D209606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=VQrDUb/O;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=i/dsQ51z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCA110E222;
	Mon,  9 Nov 2026 07:56:05 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B17F10E222;
 Mon,  9 Nov 2026 07:55:54 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A97FY5m2079969; Mon, 9 Nov 2026 07:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=4CUDwZ0f3y/cgn/B2G/DyROvbGVic8N+fzVWrA8KZTM=; b=VQr
 DUb/OkJbOp6uUQEitNyUhEvxcUawG2LTY4PMHJ5isjvmbxbyX6t4Y1CUvNltAp2T
 D6Y7eQlAlY56cRq9PQcevJx9WeVnE6sIeGDuDlNoF7dfUrussL9kG5VvBSF8oYt7
 3I8XCPaCniyOGEzG5yBNqStGA0FPSidJ/9YgD+tBO4452EOdZGYoFB/DbmBkP4xx
 miQzrBVCEFyeFhc6CZYYxUkmdC62mQqKxf3EDh7voU/HWkdsEwlhJG1fCwERLkd3
 LgxhiikA1Vk5bwuv2FTHuQEIH+Fm7iDB2cibz+oss62ak1AjuWGOega1vca0dK0r
 Kp7J9L+D2edLRAlnDfA==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022072.outbound.protection.outlook.com [52.101.96.72])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hu8pn81ec-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Mon, 09 Nov 2026 07:55:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1p51vXliXf7lVE+JvkpzcvZ/a8C1u8ZIUujhzcYGEegoab3n9EskfsqGzNJnwp7zIt0378DDAc+qF/JBNDisdNws8cZUumXsQVFqQJ3pEP3LY9jH+vhJDtP3UtEJbQkFfrwqPji2vEsWaraziOJg1SAyG9dLotUOcvuC5246oDVFBTz37q4dyLoPzmOQuhQOjFx9dda0lcY4pZfpu7s/bQzX6u/hvsUJ+A4Yj0WMqAyavdEyWRWq4ThoyhZxvnT1+vN7M0BCsC99YLP6Yf0chbEcSEdlsJ0TrOSPJ/AYHk7ILT7VJkHQZmp1dOmZH8xRcJ01PTWzZ6h6408bXGRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CUDwZ0f3y/cgn/B2G/DyROvbGVic8N+fzVWrA8KZTM=;
 b=yvPBBG+CL0KVpLOFeDE5ACKTwsLTU1FisHxCXEpKR2LqO8oHiiA1lFHlQYlQAd3jM/q9GDFTpU4zf2A6hWouLuhVOIQPJYmba2zqq5rQwuu1oO7pMSnWthkL2PSHB8s0/NIx1OBdTgs1HznehW+/A0TmlziU/IiSCCaqByzaevJ5+ciusqee1iS1TtEOWqYihXjHDBqDlv1dtXk3aOZlWZ9EMxiLwyrG9v/eCoAG9yU8+Hv3QkRju3EO+6kJwayrRE2oNqgNBebu0Ej1fpW90u2SNoD3+P/nlcc117rdh5ercv90al/Z194pD5gjlI/n2G7prvHVk+AwVqLVjEY0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CUDwZ0f3y/cgn/B2G/DyROvbGVic8N+fzVWrA8KZTM=;
 b=i/dsQ51zkac5exgt/KO/1MCwnxHgBsuuqJ7KQmEdaTjUXmGcrkJjWlDOHCUE72D8yY1eu4IRYJnFSqNDmQHo9TN4CQQ3eZPQq4CGuGbO8Xhh6+1TC9khj7YjauxKC1HA0P+ca+ZkgLv3z1pJ11Cp+bAZNqp8fsgXFCXwEKTu7CM=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB5360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:55:36 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 07:55:36 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "gye976@gmail.com" <gye976@gmail.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Topic: [PATCH v3 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Index: AQHdbE8RFSIAhRZLH0qwmhdNK1hEe7clZscA
Date: Mon, 9 Nov 2026 07:55:36 +0000
Message-ID: <9b1124ddf84702a8e8630714a5e694d476ae62f9.camel@imgtec.com>
References: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
In-Reply-To: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB5360:EE_
x-ms-office365-filtering-correlation-id: 6eb6a854-0585-47bd-0e59-08df3e36d6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|38070700021|10067099003|56012099006|261021123027099003|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Zek2VjGRw989OjlEWGZtPPxqjBGM77IwfnyschhcRz8K0x983bDyruleAd19F0P8jDYmoiMHbNF6wy66zf+4c4N7Y/YBNZvzyHWdc+J/eTk885nsDHgOVKn5h1MEk66HGf7qcawR9I99/3XmgnjzFweUY7dZUZoNgYZmHckj89DnrIyPOac3TwDs+05BW6A0b6roNdbTh+DrvYgz4jsUXMUTo5PLXe9YHMWjYH6lgRSrADm/a0tfFi17rK98t3KFnAG+q+vLpFX2hd/dxRGIelObYUyjKAXFocb/dnK98K0ms3tcUM6k88+INtztkCmPXrg7FZKJZNlbJrM8uO3/Kg9W7Ududcim7Qu1xklZaV1XxmSkxq/JpThKRHBQ4EF6yrKqHx7V8qMGma0P6dhguILismdfwk+DAfApq8oT8MCuHw0iSYwb8bT+0p6iDYftXa00ZRApZiE84DT3/ao2Mmn8lusaV60+fZDhLRCRZQ4TARK4ltzfNQcQdsMi8xrL4Cga8fWxhGMG4P2InJHAgrb1yjS9BCHasxOn+I1UEaU49FAMHirEfFwlHi3rfO+x7MiqlsLZzqXHUgIf1t1/hGAeGEKKLyuhCYhCb8jxhPdHZt+37sphFKYGdwvDrHKSbz/UyVhonDs1axbd7WOVjyvRUl+vhEL0X3KLG7y6ngE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(38070700021)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVZzSVRlSlBuaGV2ajAvcXVnbEtXTjZONXlDUnNGUkJ1NEdDTVp5YVhqNzR3?=
 =?utf-8?B?UURwU2lZZk1CWmRFcWxOa3RZK0lHMXk2SGdTcTJpOGtWZnVITUdocmJTODRt?=
 =?utf-8?B?UW9IdlRxSWV3akdUOTg3WkFvckNtWEVKdTVYcG9aUlprU21RMStuYTd1aU9z?=
 =?utf-8?B?L3J6YjloWlVRZ0hJMmhLMUh2K21wN1F5VUpwQWF6ZWlpY1MweWdNMHFJNkg0?=
 =?utf-8?B?QllZMjlsaU14M2daUFNoaWpYN0JHeFN0MmpGODllcFV1UWEwM0tNWjJSV2c4?=
 =?utf-8?B?UCtPTTRmd01IejZTUHgyNzk4RUh1ZDM3a3Blb2hVRDBmUEJ2RnBkOEhxcWhj?=
 =?utf-8?B?OUJxR2t0TlZjT3J6TmtnUTZFWks2elErNGlHM1dQK3BxOEphT2VmSmxPMzR4?=
 =?utf-8?B?SVN1RzY4cWJ3aG5ycGlCMi83UGl6bTR5ejk4VkpzRlZCVUR4d1Y5dTZEYlZQ?=
 =?utf-8?B?ZzRuRW1nR0pNWmY5NUtzNEhTL3M1YjZHZWowUW0xNzFRK0FnaEZWMlhxM2dW?=
 =?utf-8?B?R0pYMkIwbVRodVF1a29LVWlmQStuV3Jka1J6LzhhcDRLWkVJMnV6OU9IVVBx?=
 =?utf-8?B?cUxma1JCNUZmTnF5T3N1YkRISnZlYU5KNlpEZzdCMWs5MVJROGNVZEZNdUpt?=
 =?utf-8?B?SDUwZVpsc1ZhVlFPc1dOUzFuQVgzY1phTU9WQ29aK2E1WkplVGJmVkVrQXkv?=
 =?utf-8?B?cit3N0crUUVwRTh3L0g0UjNleDZIWXRQRlF4a08yUkZOYnA3RXFmcWhnUS9N?=
 =?utf-8?B?UG1ycERmNEdqQll1bTNQNUJBNjZ2REhJOW9yVFVmUkVBOEJiaVBVeXdwcDVJ?=
 =?utf-8?B?by93aTZtS0xzZkVnSkkrTXNRNi9SZFNJelFvZ0R2Nm5LdDJHZXgyZmR5Nk1p?=
 =?utf-8?B?SnZTS05ES2trWnA3cWJ6ekxLWi9tbUhHcWM2N21rQ3lINE1HNEdRKzJzaGxD?=
 =?utf-8?B?Tm0yL3JEcEw5QzJCVG4wSkJsZThnRzlNdVNkWUl0eE4rQXEzdGJlZ0F3M0ZQ?=
 =?utf-8?B?cjVhNFFkTGhRcC9KQlpGNlh5bFBtWjRvaUdyUlc4TFZRY1A1SG9NQll4YXE0?=
 =?utf-8?B?STZqTkFYVjFRc3hHY2ZCelZaS2xSWWVjTXNtQnk3RnBGS1ZleGJPY0tCWUN1?=
 =?utf-8?B?NkZ5anhpaHNUVDNqdE5ZRWdxVjBreWRYVFRhN2dyQ2JqTnpqZnNVN2RJU0xS?=
 =?utf-8?B?K3ZHQW4vellzMFJGQUxmZ00yaUkvQVQ5NzhNUTMvT1M2TUZmb3dZWTA2Vm9z?=
 =?utf-8?B?eWd4WmF6QnJWYlhEdHRmYW81bk9zUGpnWnZCSDNzSVY1YmxZUnQ1STBObXU2?=
 =?utf-8?B?TjUwRHRjMXYrZENjQUVadVIvYlFZMGFXRk44MW5Sd012TUlIMlZZQ0h6SldW?=
 =?utf-8?B?OSt3ZWRSNEhjUWlXOHEySkdiQUhaZ1ZFcklydE81VWtvbHVTYkZWSU12TWlW?=
 =?utf-8?B?SzlyN2t1cVhYWGdUTGpoVnJ2Q2IxU3NKZi93UXgvT3lreEI5Q09ZVEdjZHNa?=
 =?utf-8?B?ajRtSllRWkRXOE81dVhYRXJRM3lMVXpkTUh6QkI1VG5jS0lOeGxRd0pwUWVP?=
 =?utf-8?B?OXAvdDh5eEhCQjg5clo2RElkV2g2eEtsSUlkSFp5QkRqMDlvYmo1cVFEUjBP?=
 =?utf-8?B?dmwxbjFrWFNnOHlYbGVPOTVXVkJFSVR2Q3hrbTh1Y1JEckNRN3Z1Nys3eHZi?=
 =?utf-8?B?WU5WQ1NmUG1EaWpnUTNlV1BBbnlzbm9ENmxCakxZMHowdTQ4dFE1V1JjenVo?=
 =?utf-8?B?ckxBVXlBcmVNcjRaVTNkaTl2RDF6M0VWeTV0ZjJNTzljc1kwTm1CT1kzbVN0?=
 =?utf-8?B?Z1NRMkptOVVFaThJRzdacDdNeTF1cEhhTHhYSTlkL1kvY0RaZXdpZTBmY3JV?=
 =?utf-8?B?M1NkN0JXaXF5N0M5d0JhL3FZSXhnUWdaaXYwMTNnQTh6ZVRFVmVEQVJqUitN?=
 =?utf-8?B?QVFrc20rck5zS3RHZVBOTEd1WE9hZEJsbG9NT1ZvY1ZwWGJ0VEpOOExiUGg2?=
 =?utf-8?B?N1JuRUFzQlpjdWh0elZqQ0twZlNxeGZURW5hWnJOcFdJMDZKMGFhMFZtay8y?=
 =?utf-8?B?UUdUUjVpZXdMbndVdHFzd2srU0lBVUZXVmFlRUlkeEFuRGsvVG5tMFBWdTdo?=
 =?utf-8?B?MTFBRW0ycHFyMEloeC9lbmNJSkZEUkRQRmQzZUhZZkI1dm03YndmN0hTVmJv?=
 =?utf-8?B?NGV3bzNwRkV3Qk9wK25OUE1DS0dEKzFtZTc1YkZtSXlmejY4RGlmYS9VRURz?=
 =?utf-8?B?YzBtZlVHVHdVaFhVTnhxaFRyQU9FZEpOMEJpRkFDKzNidUkycXJFQWFJZXM1?=
 =?utf-8?B?Rk1yY0YyOTBDUllwV2pEYjV3ZG9XQkVQdXIvT3RkM3A1K1Nqdnp2dVVLL09F?=
 =?utf-8?Q?KskRpVKmWg1+3LcimTS+yIrKxSDLwag0XNJm3bxguFzAo?=
x-ms-exchange-antispam-messagedata-1: vJJ/SamzJY5ctRxViZF6GYTWB7wrrPJ5JiA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC1C31C9BD7BD48BEE0F2B1DE912EB0@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T3n6MIZBftMAli2eDS7v092UaQoRUYmytHGcUfNrzsk8NIVRyJ58mFHVHaieAVA31WMzzmqm3r3XrXLFQXCV9OrA1szuE/PL7ugDEc1m/gM0Y0M/Po9nyF2saFZZ2QR0bt7WG2uokpeoK0Z3Jb7rMLqD36mAxy3bAd8uchLMfuK5VSvmCn/IBXe1mfNWM6SpH+lh4oKR2D+M1XW02opC6lF3kC0U0PgmeoGhid5BRFBjb4NOGEN2TN3E86XV7+2jDr9Bn+kGdy6titptIlTRw6GHriKfpSflVWrTmSLfkImGliraTkzaHVjuWlO1NPRGgzc1k+p3PwIKkISSX6mRcg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6a854-0585-47bd-0e59-08df3e36d6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 07:55:36.3385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7LfIKtQziNCTTtBDzqzSTb+vqdhAGpblVIy24V4D5INIwRgcZOubRnCL0JagPWSQVfatE4zROOLhpoCYAd/KTBmw1UhQlH6R3Xv9d1ntxEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5360
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6af17c7b cx=c_pps
 a=IiE75M9YHGHzInDW0NPGzA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=rMAujXl39Y9VgzihsJkA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzMSBTYWx0ZWRfX52vyJNLvpHoJ
 DwtI9DUaZYECEuVMlnHCX4taKkBvoSQ/lw3WIwCbWeBjoF2k8HMjJmcZNVfwhe8dIIkwLNngkUU
 RB6t7n9lgoVPtuLRNk/s43JFRLXYrcU1dp3hejLkn2PNr/MNox5efwe2r7UEGe+28554sbf8RwS
 xv4J33M1glbHCW5rgdqVEu2dpmZam0lXkAi5k0EmF4f2n8VtGQuVpjXivuKrzvettfWMvwo3aFy
 bwkkUh1i551Dcj/NiBcVr98k0brdqgZCxR5XyY2CwVduplK/bAR0vdeyp40o7odO3y96R7eP7l/
 rqodxWrghH65Hu3k0Itd0Tb5VTcbLw6KRwP/SMdSQjSlgsLCOe9mE0sGIOgNilYqrLtRqICEnbg
 4YqEgm3Y7OXzpLXc7jrq9fWdc+CgPGyK+0VfpCLI6cRQYoSuui82x6VmHhOjO/UHy8jZEFjgWiD
 Pu5qGADp9cz5eg63mfg==
X-Proofpoint-ORIG-GUID: Q4cCUkSNU6KnQ0mRSfjIMUdEx-Sz-5JL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzMSBTYWx0ZWRfXxQ56X4jmFM8l
 sWOz18MyUYIAE697TK3nRsU2kEPRqsXAUFN54Np9lmbq6WwKL/rCoZSqu6xUVEEEkDiPZ57KgmW
 NFtxKUR53zRAfiDy9fTOuFp0hu+iIBo=
X-Proofpoint-GUID: Q4cCUkSNU6KnQ0mRSfjIMUdEx-Sz-5JL
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

T24gV2VkLCAyMDI2LTExLTA0IGF0IDEzOjI0ICswMjAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IC0gUmVzdHJpY3QgdGhlIGluY2x1c2lvbiBvZiBNTVUgZGVmaW5lcyB0byBN
TVUgY29kZS4NCj4gLSBSZWZhY3RvciBNTVUgZGVmaW5lcyB0byB1c2Uga2VybmVsIHN0eWxlIGFu
ZCBhY2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1
LmRhZHVAaW1ndGVjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2gu
Z3VwdGFAaW1ndGVjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEd5ZXlvdW5nIEJhZWsgPGd5ZTk3NkBn
bWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEFkZGVkIFJPR1VFX01NVUNU
UkxfVkFERFJfW1BDfFBEfFBUXV9JTkRFWF9TSElGVCBkZWZpbmVzLg0KPiAtIFVwZGF0ZWQgdGhl
IGNvdmVyIGxldHRlciB3aXRoIHRoZSAiUmV2aWV3ZWQtYnkiIHRhZ3MuDQo+IC0gUmViYXNlZCBv
bnRvIGEgbW9yZSByZWNlbnQgZHJtLW1pc2MtbmV4dC4NCj4gLSBMaW5rIHRvIHYyOiBodHRwczov
L3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjEwMTItYjQtaW5jbHVkZS1tbXUtZGVmaW5lcy1vbmx5LWlu
LW1tdS1jb2RlLXYyLTAtOGFlYzU4Nzc3YWI2QGltZ3RlYy5jb20NCj4gDQpGb3IgdGhlIHdob2xl
IHNlcmllcywNClJldmlld2VkLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3Rl
Yy5jb20+DQoNClRoYW5rcywNCkJyYWplc2gNCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBVcGRhdGUg
dGhlIHB2cl9wYWdlX3RhYmxlX2wyX2VudHJ5X3Jhd19zZXQoKSBkZXNjcmlwdGlvbiB0byBiZXR0
ZXIgcmVmbGVjdCB0aGUgZ2VuZXJhbCBjaGFuZ2VzLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8v
cGF0Y2gubXNnaWQubGluay8yMDI2MDkzMC1iNC1pbmNsdWRlLW1tdS1kZWZpbmVzLW9ubHktaW4t
bW11LWNvZGUtdjEtMC0yOTFlYWRmZGUyM2JAaW1ndGVjLmNvbQ0KPiANCj4gVG86IEFsZXNzaW8g
QmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCj4gVG86IEx1aWdpIFNhbnRpdmV0dGkg
PGx1aWdpLnNhbnRpdmV0dGlAaW1ndGVjLmNvbT4NCj4gVG86IE1hYXJ0ZW4gTGFua2hvcnN0IDxt
YWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+DQo+IFRvOiBNYXhpbWUgUmlwYXJkIDxt
cmlwYXJkQGtlcm5lbC5vcmc+DQo+IFRvOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4NCj4gVG86IERhdmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+DQo+IFRvOiBT
aW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+DQo+IENjOiBpbWFnaW5hdGlvbkBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IC0tLQ0KPiBBbGVzc2lvIEJl
bGxlICgyKToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBTd2l0Y2ggdG8ga2VybmVsLXN0eWxl
IE1NVSBkZWZpbmVzIGFuZCBhY2Nlc3MNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBEb24ndCBp
bmNsdWRlIE1NVSBkZWZpbmVzIG91dHNpZGUgb2YgTU1VIGNvZGUNCj4gDQo+ICBkcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jICAgICAgICAgICAgfCAgOTEgKysrKy0tLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX21tdV9kZWZzLmggfCAyNDQg
KysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfdm0uaCAgICAgICAgICAgICB8ICAgMiAtDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE1NiBpbnNl
cnRpb25zKCspLCAxODEgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNDlmNDBm
MTVkMjBmNWI0MDczZDUxN2RhN2VmYmNlYTA3OWYxYjllMw0KPiBjaGFuZ2UtaWQ6IDIwMjYwOTMw
LWI0LWluY2x1ZGUtbW11LWRlZmluZXMtb25seS1pbi1tbXUtY29kZS1hMTM5ODgwZjdmY2UNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRh
ZHVAaW1ndGVjLmNvbT4NCj4gDQoNCg==
