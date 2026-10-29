Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC4606A332
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=MiMyd7PY;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=mnpMPGL6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4B110E7AE;
	Thu, 29 Oct 2026 10:35:24 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FAF10E7EB;
 Thu, 29 Oct 2026 10:35:12 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8v1sj2233395; Thu, 29 Oct 2026 10:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=Zfpno1mXNRnSz32gNqLW1+jlZrM1xvzZ7TwlbxMLAJI=; b=MiM
 yd7PYqPfcwmN6934yRrHYhO1rz4bVrilem+PtuBDP+vFOcpAQQ+4IH9UCH1k9EAi
 3NYB4abbvv7CVoeSS1qrphL/dgRQPMYreqyImyxoGQWumamwkG+vEUN/Iwdiu79K
 a3LT5Lc67nmVsxrt8HW4A45gduym1L7Ux9x2ewYxkOJ+bqgwGwFkbGABudZ3b7Yh
 kWie9IeFn1UwaM70r00jzbjXVVYmy3QYXzlaiYzvTEXMdc+tyNgIUz0I5Hau1hxl
 EXTIXWa/DGFYRyxGDuh+FLCDdOFUTO0vlnjPdWFsBJmRSmOGZnbnsE21jVCjPBLf
 niPvNugp2YyHDl+Wcqg==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020123.outbound.protection.outlook.com [52.101.196.123])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hkvbj8bp1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 10:35:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmWL7fCUDMXYIwrfQkrt0IXrxqs54toZiS7ld02XEqhnzIpfxQrGNbxMFqmWzdFKSINjcuX+yg0wTQd1kWMLzikw80SVXe7nCNhH2ISsfrkijTZX85e5HUx/Sk/ApkDgL4H1ZjWpObnLge/T7HPFfCETqo3GDSnoWJh73ZIl1gr396s8E+GGYHtwEhVY+s/qp4PI2fvz+3PnPt86mOJnN+siCkvDLuxk4XvNKw5z9FKA8Kykx73SiYeAAuZtYVwRi/1a7ht0buwC9D6ulsTiZrYS36Y7AkbwJRuxpIZmlHVNHbVnmAGyKbeNSOSJfzGK7laYOlGa2mEW/xZ5umJomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfpno1mXNRnSz32gNqLW1+jlZrM1xvzZ7TwlbxMLAJI=;
 b=Mx5jHeK1vAGLPsNs+woAOPo13sG6AeHI7FEnSFMb7tMFCjsSWei+acQa9BF6OJ9DrOtBoaxxWe3thj3tedM8F+EXq2DsAYx2D3bGL10OCbHwCbT0FgXiaZpnDtEp4sXlG3jymnSVLYkB+fVag0x05cqlhq+J7oVK9uGL4f0Abe0NMeti7/YMAEpvtr13VZObm+voS3yfaGU3PtiUs5JwGGOLEhcbUmARkgb3ir7sZMAt3qEayJnoXIVm1GwzhrrI52Xkto2pAzns2zChlf+XcbCn7D9hPfhtWR/shg3TKDz6Y4s5NTJ3gBH9+qkjEGi7vaY8pBqbdWw4haUPhcNuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfpno1mXNRnSz32gNqLW1+jlZrM1xvzZ7TwlbxMLAJI=;
 b=mnpMPGL6IqCo3GWjB3pFVkmhUd3gtrUixTcWhmg6hAim4Hdc0am+UhlSx9wbhdBc5pdnrepijS6Soo3lyLHFUVdyl3gq6JeuVSG+q6rVD5hHY4aFhToRnYO0ZFTZqeT4kQj22jaK873JWEN1YZqPhQTmnhPks+8M4YrlW1D+uUw=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LO3P265MB1881.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 10:34:59 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 10:34:59 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 Brendan King <Brendan.King@imgtec.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "gye976@gmail.com" <gye976@gmail.com>,
 "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Don't retry a failed unmap in
 pvr_vm_unmap_all()
Thread-Topic: [PATCH] drm/imagination: Don't retry a failed unmap in
 pvr_vm_unmap_all()
Thread-Index: AQHdXIVfscPLGgTsokOVDiy0GosjI7cUaT8A
Date: Thu, 29 Oct 2026 10:34:59 +0000
Message-ID: <0c18592412286664cf1d29b920ffbc1d139d57e9.camel@imgtec.com>
References: <20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gmail.com>
In-Reply-To: <20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LO3P265MB1881:EE_
x-ms-office365-filtering-correlation-id: b4fdb9bc-ce2f-4f33-b0d5-08df35a8482d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|921020|56012099006|261028144727099003|10067099003|261022115727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: tiOJlnkqvbYGyC6lk3eSCn6c0YMhm4udxzuqLw7Eg0TV2H2lbzbwtL/1oNtqEpBMcKfstLpckjGDy05fOaZcAVRyzacHIqB5bsPXF3Xq8dQUw5Z0a0AKI+Q1d9z34oOsgia8WVxuo8+HJSXU6MYYHqsjLT+uvXYlPLHPHMIY3j05xYZlWoxzfYEa1XVxg92G60TcawrBi36VLv2aun4mYkPbd6KxpNxSqMU2aSIXDaKm5804WffLxZHqIMSWZixmgEXloArQTn+sUVxa2BZA6qXtQd6uuxzkd51FoAKWLmzl/o8NUI7nR/75jOwavxU7Xv8NiCeoILYQ6G5lm9DXN2QRSKjXpFvp6rCeufDmMB9u34FqJfPG1UZTE6QtWmkr5EE5ODRpucjSdcwBEYN0uDW6xjPE/f5Z1SizAjGitOHmbrqu82n/V0ny+UpDO9+wcEevRbHhspqtF1lSWuQJprgVbbm5UlIjmHjo4LP5snaVHE2n/wKppvXfw2yi8HU6+gOobuSzJ089mg9A8Yxiuzi7jQrZl+Ef/zQMxLdWTTUr2Hrs1KkExfXzyhC3019ZzfuJcROr/8ZVTvZnyybSjeRLoEZwLFt0ACOW4k0n/pSdjHzR9JS+FXOCtORpCQe1h8tMmd4VA9rc73Drssi3IxnmRa9V4X9MzIowcXDS0tIvVTFJweJOEYjJq2er//Bu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261028144727099003)(10067099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjB4NUJqdXRnYVNRSXVBbGw0ZmlVeS9aRVJlRUIyejZoZktWTE8zSGRZSi9h?=
 =?utf-8?B?Z013Zjh3alVrVmM2R0t1LzNkRDMrNithNVlhVTFROGtTVlBwdStvZ2dqSVM5?=
 =?utf-8?B?RUFlR1Jnd1ROQ1ZiNVpScFc5d05GSE1zUVN3bU1tSzN0UDZPTEV5MmllaFlo?=
 =?utf-8?B?QUFNcnhsNGFJeXdSYlFnRFZmSnBweDdjRG1yaTRpcS9TaVJ2UVU3WlZkb1d3?=
 =?utf-8?B?RlpnaGxnNEtNd1pYSnhzTzJodis0ZHpvbno5YmZEU2tTNGRQcUhqMWVmZnNm?=
 =?utf-8?B?KzhPN3ZJRDNNNlJjMlg5cHhWZTViTU12akJiSkt4K2lteEFseS9QTnowMzY1?=
 =?utf-8?B?TUpMOFJFTGcrM0ZseVY0V2FtQ2dVclh2bnI0eGs4ampWdDhuekozU2M5Yllt?=
 =?utf-8?B?QWE0aDBEMmtsZjduWHJRd2p0akhQV213cHE2dnhrRFgvWUpIZlNlSkV3eVhV?=
 =?utf-8?B?THhuQzFEZ2JndWRvSjdZMWFIU29acDkrd3RKcDBvd3p5cmpsOUxnRERCZjRu?=
 =?utf-8?B?VklDMk85a0szY3g5OWx5bGNpR25ZVW9zNHFPTHZKMFF4cC9hdE1yZHlEajZO?=
 =?utf-8?B?S1ltS29NWHVHTTc5ZGY4V2pVWDUwYkIvbzAxT0dOSGZLWFBiTVlhekJKZHcv?=
 =?utf-8?B?cHBocHRaMjhLbWwwaWNsSWNGSWxIYUw2ZGZXaFFrKzVPbGdyRGdXbEdtU3Za?=
 =?utf-8?B?K0s4em55TWVhcUFjYmhvVjMvdnhiY3JaWGJvUzBjMDR4V1lGREJDQWpMdHJh?=
 =?utf-8?B?WEhCVHJ4cTdUbGVJaUdtMWtCTnBsb25wMVR2K0lUTHRIZXB3ZThLcWZoNTU0?=
 =?utf-8?B?ZG9STnRkNEc2T3B0MEZpcDJ2WWU3WCtKejZ4VlllbTl1MUM3WkZkN05Ncndu?=
 =?utf-8?B?YzZkemRmK2NpSitNR3R1dmNFZGRxRnlOcUVRTkFKbXhObG96RTJoQnlBeEdE?=
 =?utf-8?B?Y2hLekpHMzMyc01rd0V0RmI4bklLUnJacWF2NlQvUFY1V0paeHFKYTNxekM2?=
 =?utf-8?B?cm9VVEhrTGdnKy8wU05nMENKbjlVaHFWeG5kZ2Y5MWZrZlRROWIyUmNNTFRD?=
 =?utf-8?B?dGcyaWFIY2k0N1VSNlUvVndsZ0VQaUhWUndQR0t4N3U0Nk8yS0FDNFdGSjZp?=
 =?utf-8?B?alJvVWhFWG02TnVxQmxUU2hSclVEM0dwVXQ3OEdBNjY3b1BqQXhpU0RRdURU?=
 =?utf-8?B?TGF4bUpoZUtpZWFvR1RwTWlRRHU5dDdUVkFIYXhDZ09iUklZYUowUnY3cWZa?=
 =?utf-8?B?dEdLM1NaeWMrV0Z2OEd0SzVVVXgrOE1Ud29FMWtqNWFQQzVUMXJCOE9KVXl3?=
 =?utf-8?B?MWtQZ2pqT0V4d0Y3azNwMzFiVXBtcTB0UXQweDFCU2w1NjlXallhY2JqVEFr?=
 =?utf-8?B?SndOQ3BPNkVDcmN6cllWVEVkWHRGZmhySjNjQ3RoYkgvdGxVa096OXRyT1JI?=
 =?utf-8?B?SlNMejczTk9uYi9raDVFUS85SHdKZUN1c0F5dGF4NEVxK1BVNFR3S3BML0xN?=
 =?utf-8?B?VmI1UEdyMERuUnBHUi9vbll1bzdLVllTdEcyd1dXVnd6TURwNGpWNVZyWWs2?=
 =?utf-8?B?dmNOMFNKWDgrZzUzQndLS1hKZXBQUDRFS0JxQmduS1o1cGxGdGJRNU95TGtS?=
 =?utf-8?B?OURvUVRocXlnZENGWG54QlZ6N1E4ZTRYQzhTU2pWWkZtMXhRQ1pmUjQ4QzYr?=
 =?utf-8?B?a1BpTGh5U0pMWmo3b2VsNkJUTktRR1UwNW9IbE5malk1TkF3dGR4YlRJSmFy?=
 =?utf-8?B?WkJtbmQ0OUtWU2VSSE1GUFU3QlF5aUF2bC9GdnlMSDRwMnJwaWlJZksxTFBr?=
 =?utf-8?B?M3owSXdXYjB6RVJGUXluSDVZcUdsMnN5WWhrVS9ua1FwVDFmdGg0d0xCbUFF?=
 =?utf-8?B?eUtKbmltSWNGWkwzY2p1QWpETUJaQkRGS21rVUEyY2JjelV0T2FSaHlhT0RF?=
 =?utf-8?B?V25jejNMcmU3QTJzQXA3bjRIaC9ZT2RVS2hEaEg4eEltTTVIYVQ3S3d2cEpJ?=
 =?utf-8?B?dncrT2kxRFAzbnphZnRzSnVyazl3K1E5dXhIOGZ0N2hrcVk3N0pNQzYwYkc4?=
 =?utf-8?B?SkRFY3g2NDJIS2g0RXJLQ2VDR0pGODhOTHBlcE80V3VZTHVBSmttbkZta2dt?=
 =?utf-8?B?Tk9BeXRXM0F1TitmZk5TMk51ZUdOTEJ2TDgyeGFxSWJ5L2R4ZHdWOWdYL2k0?=
 =?utf-8?B?Qkg3ZlRYTnc3WDgwR2hTa2JsWkxBTzhhSFF4OGpNM0U2dmRSOWhiYUNlWnU4?=
 =?utf-8?B?TkZkZVBqNDZWcXhPcU9HR3NZVjdseEZhN0x6Q2FqeXJacWloeU5vT3p0bENi?=
 =?utf-8?B?T2JsVWV2L3U0b3ZiN3JrWTFaSTNWUSttcUFoM2xneUtZY3RvSFNFck5PSTc2?=
 =?utf-8?Q?RhU5duEtYpO3ZqZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AA87BDB76C2CB4BB10A9E6CAA679B91@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RmzIoYfa48A2LngvNX1yj0pnsc/rvdzuHiCaTkpG361kIXnbL3JEdkLa3K23dIMKpskKtol6LPiPRMq5bQ+3GISarYW/zrAi09jmOSka1vfPNXlQu+1q3wCkyB/9NlLC14cZNG+0ch1YlDn1WBhtXkcGQwS0v4RTE9Sb7L4hzsbSBcWnhM3L4p5Wp/FE3OtpLa7WfaN9bOeGX0A0bf6sZQPjujWxHogzyO9jvgkql0pvvYMHi/JuqbHoUDwqt1KGZNGtMk8tx0QDlqj44VclX/XT2ZYRTjtKHTLN185CtXvhAVsllkoS4rzTcAFDECyTIAF2J+h191lYlrfhXLD2FA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fdb9bc-ce2f-4f33-b0d5-08df35a8482d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 10:34:59.1594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFDwHQKltZRSojxoBp0iEHVaV94CCE+EvniAOWd8bcGrjqXrKqwXWTk2gdK4gLLMc8HPAUQYf/CDG+iKzuvVNNI5xKXmbRNaqMqjMJWb/8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1881
X-Proofpoint-ORIG-GUID: temYOCNcDm0dPt-wWTHbXoEM-VE6AiKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX4Ufhnbe3ytu4
 E1u3ZmSbM6x56kwhmlOtp7K0ZXYlJqRe1Ax06AO3t/mqOKwkFa0Ruc6/diQ5sp908ZFVDehY6Ir
 csVrIYS/ywrBGN7akGijCdbgifQSApbHuwRYWfEi2u40V6awAK+ybT6bG3LptvldV+8f6OKfOUU
 LlIuLMUC5qQAkpBAAbqUC0zwzzPF8wsw/xh4vl36EDEMt5fmUGSX+I0Z3pDc/X7cpSHoFAjWDwh
 +YAKBLt/8oD6p1FXM3K3UknIMEt7kUZITFZpLor3kyCLp+f9v0MHYMD3TpN3vDTNlGxpZDMl+YY
 8xUlcJ/gTmtQaWh8Hp7Qb2rMHmFd9LMacVK/Yt5YX3FoIILDhXA49+tym01b9/6jgB3Eak++bOt
 q/C19Xf80SsbyJaiacet7TGGe9I/LxNLWMrf/PmdroqS0RsbTjPHLmKkfsGOh6RS0sI04siLqfa
 viDRJrdRbA4sdrrAu2w==
X-Proofpoint-GUID: temYOCNcDm0dPt-wWTHbXoEM-VE6AiKT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX+iw6dd2J/bNR
 gUmV7puZ3ALJhRrPQuju2MBTw4LpFyL4KTsXIZqrE/UCU9qmQrUbUE/mlz3UL15FyQsJKNW6BqM
 dBST0DA8X7ohN7+6Jzfzd4gFoB+S7do=
X-Authority-Analysis: v=2.4 cv=NvdE4MdJ c=1 sm=1 tr=0 ts=6ae32157 cx=c_pps
 a=Q587e1aqQkEIxz2d3WDsqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=kLSyXLKFSiir8NQjxI4A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDE4OjEwICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
DQpIaSBHeWV5b3VuZywNCg0KPiBwdnJfdm1fdW5tYXBfYWxsKCkgcmVwZWF0ZWRseSBsb29rcyB1
cCB0aGUgZmlyc3QgVkEgYW5kIHVubWFwcyBpdC4NCj4gVGhlDQo+IFZBIGlzIHJlbW92ZWQgZnJv
bSB0aGUgdHJlZSBhdCB0aGUgZW5kIG9mIHRoaXMgcGF0aDoNCj4gDQo+IMKgIHB2cl92bV91bm1h
cF9hbGwoKQ0KPiDCoMKgwqAgcHZyX3ZtX3VubWFwX29ial9sb2NrZWQoKQ0KPiDCoMKgwqDCoMKg
IGRybV9ncHV2bV9zbV91bm1hcCgpDQo+IMKgwqDCoMKgwqDCoMKgIHB2cl92bV9ncHV2YV91bm1h
cCgpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1fZ3B1dmFfdW5tYXAoKcKgwqAgPC0gcmVtb3Zl
cyB0aGUgVkEgZnJvbSB0aGUgdHJlZQ0KPiANCj4gSWYgdGhpcyBwYXRoIGZhaWxzIGJlZm9yZSBk
cm1fZ3B1dmFfdW5tYXAoKSwgdGhlIHNhbWUgVkEgaXMgZm91bmQNCj4gYWdhaW4uIElmIHRoZSBm
YWlsdXJlIHBlcnNpc3RzLCBlLmcuIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmUgdW5kZXINCj4g
bWVtb3J5IHByZXNzdXJlLCB0aGUgbG9vcCBuZXZlciB0ZXJtaW5hdGVzIGFuZCB0aGUgdGFzayBo
YW5ncy4NCj4gDQo+IEFsd2F5cyBhZHZhbmNlIHRvIHRoZSBuZXh0IFZBLCB3aGV0aGVyIG9yIG5v
dCB0aGUgdW5tYXAgc3VjY2VlZGVkLiBBDQo+IFZBIHRoYXQgZmFpbHMgdG8gdW5tYXAgaXMgbGVm
dCBpbiBwbGFjZSB3aXRoIGEgd2FybmluZy4NCj4gDQo+IEZpeGVzOiBhNWM0YzNiYTk1YTUgKCJk
cm0vaW1hZ2luYXRpb246IEhvbGQgZHJtX2dlbV9ncHV2YSBsb2NrIGZvcg0KPiB1bm1hcCIpDQo+
IFJlcG9ydGVkLWJ5OiBTYXNoaWtvIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Ivc2FzaGlrby1vdXRib3gtMTY3MTQ2QGtlcm5lbC5v
cmcvDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEd5ZXlv
dW5nIEJhZWsgPGd5ZTk3NkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgRGFk
dSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxleGFuZHJ1IERhZHUN
Cg0KPiAtLS0NCj4gVGVzdGVkIHdpdGggdGhlIElHVCBwdnJfKiB0ZXN0cy4NCj4gLS0tDQo+IMKg
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jIHwgMTUgKysrKysrKysrLS0tLS0t
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gaW5kZXggY2JkZDE1ZWQ3
NGZkLi44ZWE2ZTg4YzhiZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Zt
LmMNCj4gQEAgLTg4NywyMiArODg3LDI1IEBAIHB2cl92bV91bm1hcChzdHJ1Y3QgcHZyX3ZtX2Nv
bnRleHQgKnZtX2N0eCwgdTY0DQo+IGRldmljZV9hZGRyLCB1NjQgc2l6ZSkNCj4gwqB2b2lkDQo+
IMKgcHZyX3ZtX3VubWFwX2FsbChzdHJ1Y3QgcHZyX3ZtX2NvbnRleHQgKnZtX2N0eCkNCj4gwqB7
DQo+ICsJdTY0IGFkZHIgPSB2bV9jdHgtPmdwdXZtX21nci5tbV9zdGFydDsNCj4gKwl1NjQgZW5k
ID0gdm1fY3R4LT5ncHV2bV9tZ3IubW1fc3RhcnQgKyB2bV9jdHgtDQo+ID5ncHV2bV9tZ3IubW1f
cmFuZ2U7DQo+ICsJdTY0IHZhX2FkZHIsIHZhX3JhbmdlOw0KPiArDQo+IMKgCW11dGV4X2xvY2so
JnZtX2N0eC0+bG9jayk7DQo+IMKgDQo+IC0JZm9yICg7Oykgew0KPiArCWZvciAoOyBhZGRyIDwg
ZW5kOyBhZGRyID0gdmFfYWRkciArIHZhX3JhbmdlKSB7DQo+IMKgCQlzdHJ1Y3QgcHZyX2dlbV9v
YmplY3QgKnB2cl9vYmo7DQo+IMKgCQlzdHJ1Y3QgZHJtX2dwdXZhICp2YTsNCj4gwqANCj4gLQkJ
dmEgPSBkcm1fZ3B1dmFfZmluZF9maXJzdCgmdm1fY3R4LT5ncHV2bV9tZ3IsDQo+IC0JCQkJCcKg
IHZtX2N0eC0NCj4gPmdwdXZtX21nci5tbV9zdGFydCwNCj4gLQkJCQkJwqAgdm1fY3R4LQ0KPiA+
Z3B1dm1fbWdyLm1tX3JhbmdlKTsNCj4gKwkJdmEgPSBkcm1fZ3B1dmFfZmluZF9maXJzdCgmdm1f
Y3R4LT5ncHV2bV9tZ3IsIGFkZHIsDQo+IGVuZCAtIGFkZHIpOw0KPiDCoAkJaWYgKCF2YSkNCj4g
wqAJCQlicmVhazsNCj4gwqANCj4gwqAJCXB2cl9vYmogPSBnZW1fdG9fcHZyX2dlbSh2YS0+Z2Vt
Lm9iaik7DQo+ICsJCXZhX2FkZHIgPSB2YS0+dmEuYWRkcjsNCj4gKwkJdmFfcmFuZ2UgPSB2YS0+
dmEucmFuZ2U7DQo+IMKgDQo+IC0JCVdBUk5fT04ocHZyX3ZtX3VubWFwX29ial9sb2NrZWQodm1f
Y3R4LCBwdnJfb2JqLA0KPiAtCQkJCQkJdmEtPnZhLmFkZHIsIHZhLQ0KPiA+dmEucmFuZ2UpKTsN
Cj4gKwkJV0FSTl9PTihwdnJfdm1fdW5tYXBfb2JqX2xvY2tlZCh2bV9jdHgsIHB2cl9vYmosDQo+
IHZhX2FkZHIsIHZhX3JhbmdlKSk7DQo+IMKgCX0NCj4gwqANCj4gwqAJbXV0ZXhfdW5sb2NrKCZ2
bV9jdHgtPmxvY2spOw0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjMzQ3ZmVmNWY4Zjg5Mjc5
ODViZDY3ODM1MzMxY2U0Y2Y3ZmY0M2E0DQo+IGNoYW5nZS1pZDogMjAyNjEwMTUtcHZyLXVubWFw
LWFsbC1sb29wLTk5ZmUyZjJiN2UzZg0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=
