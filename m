Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA431606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=PoSQNxH+;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=DUcH2zAC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4009710E28C;
	Fri, 20 Nov 2026 05:36:50 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D5310F0C5;
 Fri, 20 Nov 2026 05:36:38 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AK4vmJ11200742; Fri, 20 Nov 2026 05:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=ugbT4wDYVj1xZdj4VVyU/2J2yyEIgZZHTi8KnEQjv28=; b=PoS
 QNxH+KG43KyCGl69udKm/nHnKgEFqK8l5nTYTJEACnMn45RSia8IXrJDbKKQXq2K
 iODb4+pda+7ZaS62b3/HsVPWAv7MhytU/EzC518vsb+07m69+FaDfziveWsHRuom
 LmqVI1Hi5bUJuFCwPPJ5TRbBbnN7bj3TCj53whtgQkLuz8vho1PGl8tnm1jSF+SS
 SPBgFmY013t0iqxOpQax6HtHijcLcsolwQi7o+KE2SzhiUUCQMZ9Cv4eQwNZvH+W
 oNpvyyN8JGwcNtdDLZYsaJHorhyjNTLXTpV/L6YCMhN/LfIPkxGtAogtwwOvVo2D
 96hXqIXp+QTpr+S0PlA==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021109.outbound.protection.outlook.com [52.101.100.109])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j1qh1h2k8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Fri, 20 Nov 2026 05:36:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEflYSftg0g66xSfi71JVlK4s5AJjYagT6p+wK+hlx65RzL9KRdDlxBfchOSGDbTgJrTZCJWWm8Og6JIUy4haB13Ty9AXgq/NUx3F2QHry/EG+dQVqH9C5p4bgr4G9r+dAhvPHPBLKY5a9ZPkcjQ9d8Mh8FRoY0c3RPlxQhbBs14VdFa5pvWbyKFCqjFw1A7XJolMFS+Be9/WnsD+JnUY5Bwzn4Z14AppExETki+9xrUkRJh9xJQktQP4liDQC5ojGUHL34M2fYXHxDRU0ISWcbSW/pXmbCqBpU4/q12ig9yKOiE8LsXtYKmYAx4MFOyIK/Hc2xjjuHRCDI0jGaxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugbT4wDYVj1xZdj4VVyU/2J2yyEIgZZHTi8KnEQjv28=;
 b=umituZw/h3VC3kLaBXkn6EmBL9XBXhje1dAnyAoPkp+eFS8n0T06SgopyzCmULQdYHP+5TmuZL/gS7DhxLAW4jhwcFtcpF5+MvsP9SMWiOZIDKeAmTlobEFWF0bzcA4pWnoaUNEDbr0JnnwdpDfIPCCRdqgrESecvPfIFJS0avNElI0hrf7+RA8nMMLD+eVk7shA/uD/kXSa7IdgKZ9SUZ2TpdRhTZz8fagqCq+GrxE6PHda2vNGDLr1E1utvCUqOP9YKcWe/rK39hYeg+G46UJHcOGezGmGCWaBIZnEk/+W1Q8nxQezkG5yp86BKBhNN94nu0oZlid9yZhuXkXKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugbT4wDYVj1xZdj4VVyU/2J2yyEIgZZHTi8KnEQjv28=;
 b=DUcH2zACfVjgGrcTYbHVlaUFauYS+c/ahm6gI4StA35xpY9hWIy5bxrDW/9bIpToBriX96I8EL6yaIszCPNbUhIufIjW3482zg1DlRwi5iqhfDVAqkGBB/phrLWGPG3dauC0Rcd0ps/XWQlAF5ZILOKe0uaBGeQZF+Lc5Sy+5vs=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO9P265MB7860.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 05:36:18 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 05:36:17 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "donald.robson@imgtec.com" <donald.robson@imgtec.com>, "airlied@gmail.com"
 <airlied@gmail.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "sarah.walker@imgtec.com"
 <sarah.walker@imgtec.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
Thread-Topic: [PATCH] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
Thread-Index: AQHdd4EVdanCe0lrUkGyA5n7nENiGLc2cxyA
Date: Fri, 20 Nov 2026 05:36:17 +0000
Message-ID: <cdb57b7964a0b2ef3c540b0d85defa2746b4be4f.camel@imgtec.com>
References: <20261118-rbrue-suez-pvr-compute-overlap-flag-v1-1-ae8b48a17dfb@gmail.com>
In-Reply-To: <20261118-rbrue-suez-pvr-compute-overlap-flag-v1-1-ae8b48a17dfb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO9P265MB7860:EE_
x-ms-office365-filtering-correlation-id: 08c3ca14-f1f9-44ca-0fff-08df46c83353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|921020|38070700021|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261022115727099003|261021121427099003|261021123027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: v8dTyJk36B31cuOGcAY/ZWsbyd00LkW726a8eaCqDCB+y/aryqVzRyv0THqw3iJbq52JKw7fkHXANcC2CNksk7Z5Rn7JhxsO6Gx/zMqIhUrL7V2o1BiOzdJFPN+ZsTptoAN2OI9SrHBREJ/VDdChC369NZX0UBL0Jgplzex//tBWIwhmRfN6beUgc2F4nGwqpNNbYuJqY1otKytY4wEiElz/tvAVBShDUibAPaE8mgC8T+EDSdmy86kjzE8MitfvLPXr/jA5UckWiEaL+xOc58DpTOcHZZ2penfZIC+Zy3rrQh9fk25vtot0mrKrw/iVLJldhzKrd1ddh6ER17/NFBUGmVupy6U+ziUliht5AibgCj1X3Q4TUCMWKOuKmz3G9dv40ekGRt0EPqLlkEcGXpE/CpxgnBDnSRP17+Rb4Fa91cg99d4gxEAOUB1JeziILlVYUM6hBHTYcT6HpXmZdIUZe37f7uBa1YvpJbJHzOBssP4VdKi/Knlx2C2s0axdMm13DCL5wy2nJZlrQrFuELcjYDwWfQcQpFX2NtAhyQ7IDKnF7Tcz1NiIgn6VClx/3gSMCtYW/sLOs6oKrpo4fS7+IUgxZ4sPFrTJhjGFHIYhcTHQzJPzudVn9qPANTWNzEiLPhP3Dww2afiTzs0OVM3DAgaWLCPBAiHTYXJB3SKJasYHirgV7hQwA8+Oxcql+B4CuQLEXMSQBNOQkYyg4XGzg+6c44JHNjRAzqxI7nPK3IGBdjzLvCkBsJIs8UhT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(921020)(38070700021)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022115727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTF5QzBRV1pLZzVNdGZnSjlYY2RHRWJESUcwN2k2OXdpcDdneXVpUTV5aGQ4?=
 =?utf-8?B?cTlJL1FnNlJKNjAwNzBpamZNbTFtQ1NWSGFNZTcyLzN2L0xFYTVCbFNkMGdD?=
 =?utf-8?B?VUpyZm5tR3h0REFKR2p5WWlWb3REYlV4RFZnd1o0VjNDSWRGWk1OVXJoK3Rl?=
 =?utf-8?B?VWVRMWNHYjY1cDIvUEFkMEFSdWZJbTlkWHBDWEJtUzlwbG9SR2NLWWJYL09q?=
 =?utf-8?B?cTdSeUMvK0pxTTExaURzM25ZM01sZC9kTGZ0UzdPMjRhdzZvM1hPNTVtYUY1?=
 =?utf-8?B?MVpJWkJjRG5SWjNCdXBpSHhLYmQ2UFh6cVR0MGVWY2xKRnJiTVdNNlc2bUN4?=
 =?utf-8?B?RFE5TmpxQW9KbllNNkFNQ0NTb0orNlk4SHh5ZDByZ2lKWWJJMHlsZ0xsV2RQ?=
 =?utf-8?B?c0FNOTNkMlhYT3ByVG1SREd5SjQvdGdITC9kUW9KSnc2aWxENU9NTmJ0bGxt?=
 =?utf-8?B?UHhvWkY4ekx1TGJPM0ZwbEVwM0h5TTQ1Qk9ITC9Fdy9PYW55elprNHc2Vkpy?=
 =?utf-8?B?ZmlaUkxrWGJib1lmSkRjRERUWnM2OHVWQWRGM1hDSTcyWFdBbXBoeVRBUUZk?=
 =?utf-8?B?VjRyTUwvMXhKWTluN3hFUjZHNGF6d3FPd2NPRHFwYndPd1VydHpReG5sZDJJ?=
 =?utf-8?B?T09VWXVjMEh5Tyt0T3FtNnQxNmRiNWFIWTFneVQ3d1RpYkxXWEZRNTVsMEtZ?=
 =?utf-8?B?RXA4MFlmK3phRkhxTnd1cTYzY0pRbzBWMDBUTzgyd2k0UHR5TkZLT2hTSmRo?=
 =?utf-8?B?ODZ4dzBXbUphTm0wU0syVWVYanZXK0hleUYwb29uUFdpVGt0R3hYYzdiMTQw?=
 =?utf-8?B?R2R0UUx3elQwQldpcWRlT081S29YU3dYTWlnaXJraGlnZ1RsUVZhRHdFY1cw?=
 =?utf-8?B?eXgxK2lnTkN1MFRneXA0dHN5dDRqc2I5dlJodFIwTXlhSUFBTkJIQUp5bElo?=
 =?utf-8?B?b0JhSGU4ZjlNVUV4THZWWFdxblRSUlpydjBIeDBNVU1adkRsQjdyQnVUWjhi?=
 =?utf-8?B?eGIvU3RodFB3a3Rwd2NtbUFXYnM0cFVrbk1wNU5aRFJSUWd3MElLSUNxdUhR?=
 =?utf-8?B?ejlLL1JwdmlwMHFLSDNNQTE4T3VTZDNiSFE0dkxHbEJISER5QWFzMHZUajVM?=
 =?utf-8?B?cWF4VHdVbkVtL0JKRDdrL2l4blpDWnRZZ1NLekZySlphZktab3pacjlrb2gv?=
 =?utf-8?B?TytoV0U4MDRWaEVTdXpUVkI5eGgvN0wvck5SekhZM2cyc3hrOExFWnZYV0Rv?=
 =?utf-8?B?ZlMwUVREVm9FT3pjdEQ5aTlLNG1SdHQ3SDRkYlpaQzNoMVhaZGViUTJBM0RF?=
 =?utf-8?B?QVdSZGJ5WUZOa01JbVp2djN3SDZzaVhXckQxOXlLN2ZldVF5a01adFRoSTBz?=
 =?utf-8?B?VTdpU1l4ZzZWYkpOdkZkVnpSNm16NnYyQm1rMWxUY2hvTEtBdlU2eXhuRHdR?=
 =?utf-8?B?bDBSNUtWSjFrV2tyMEVENldlK09BbUV1MUgvMG1xU1JvaTJkTnovbnVLWmdI?=
 =?utf-8?B?T1FFTDM5SFJoc25rVWloYXRHQUNCTXNSU1lSUEpON0VMeE9NSnd5V3VmZ084?=
 =?utf-8?B?aWV5bW9kSGpGTnJwT2lISjZOVkErciszc2FXblZMa2p1djFrZ3lSaVdmRUlw?=
 =?utf-8?B?aXhMRmU3TC9oaVBncDZQejhiTzdVNllwM0FqTUExMU5pelIwR3NNWi8ydkdu?=
 =?utf-8?B?TEM2dGtuWUpmNkoralU5cjhTTlFaZ2lvdU5yOHFYSWZubllqOTRJaU9tZkt5?=
 =?utf-8?B?RHhPRm9MQ04yNWROYWpBbCtkanJmalJhN0NOWXFrS1FQYy9pSkl1OHVJN0Vr?=
 =?utf-8?B?MUdqTkRJMml6V2lsVmVCbXNyZU92aDF2dWFYdGNNSlBlZUc1OHNwcnVsRFo3?=
 =?utf-8?B?eFRDaGl1WEpQaSswOFZRMEY1UXk3R2ozT2xyNXY4U2pGRDlWZVUvWVlKRGJj?=
 =?utf-8?B?bFZHRUlTekREcXRpcWNXczlCNk9qdktVNFk4VjF4MFVCT0NlbG5VRVBBY2Yx?=
 =?utf-8?B?dnhCN01tSjhkd1RtMURZalEzWExuNlBVMU5LaGlXbkNUenppekJlVDhiUTBS?=
 =?utf-8?B?cEkrcWZ0SWhqeGttOXhSdkIyaEM0TWpXYk85OXpOSjdJZXVLNHZtWG5FTC9C?=
 =?utf-8?B?MlQ1S1JZWlY2M3Z6ZGFmWHFFTDJLV2JtUDZzMGxvL1BlbjZjdmpFbnpNSFd6?=
 =?utf-8?B?RWFFS09iTEJQd1pLUTBQNVJLR2VPcllBUEoxQTBrYzV2U0lXSk5GSGc3Ri9r?=
 =?utf-8?B?SGVRaXFGejNFVnJPVUROcS8za05GRU5KSlFBdkpQbmpSd040S0FCVE55NDMr?=
 =?utf-8?B?VUV0eW1OZXVuaW1zYmdrcmcxTEpFdS8vNnZhRkVESDVISDJrUjB6QzNaM2Vh?=
 =?utf-8?Q?kI6Em/G3Q7yTTxg5MyZc1O0xpHrF2V0NEIYzQq2oxnFc8?=
x-ms-exchange-antispam-messagedata-1: dXnzIm+2Q5nbBMjAiwNZ3l7gLCmgpd3kb24=
Content-Type: text/plain; charset="utf-8"
Content-ID: <337DD9EC98AA3444A09864D57459AC3B@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oddnQITn92utx3KRDvFfZF02Mwa8n7QjmGVtxgQTzB5Ho3apZ57Qwm7bv2p+DBSFoSCGWbo9b8eoDUdTjhdEXdy2hfic6TWu707F8M4HmlkCGZ3nF7foQ6iFE/Fh+q7ufzH6QGoTJUGiIuvgjS1gc4jPboGy7H3OlWjP8u0/zLWNS0SOKBs2NNtgaxKs54XpI8aGHjZHGre5jRiR6o2SVB7YUROZcG5GMAacWFFnqlggCee06twxu1g97yMwGsd6IBPolXc/5H3OkMC39sQvlIvKenNI0F3RIXI3zikXGrzStwtmxOdjIJHYRcx9KG/+vNIi5hGPMFE9ABPPhOou0A==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c3ca14-f1f9-44ca-0fff-08df46c83353
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 05:36:17.7832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akYNpOUdzV1GRog+IyQI2nhqxyqaySepIY/SP4RHCd4MCawy0YPUfa5uLNeRpjrRxxvMu1mdKhChyldmV/cpANnT0yqX5lHYdW0TZjSKhnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7860
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyMiBTYWx0ZWRfX5v49wcJl8HgL
 YDg/VXSchxB7HgucaNiLwVbwuUoKmZtizb7UL+ut5XVfjBfDhMq3loi7MY6nyyafGnliF74TWSp
 GRayq10Oagg2xX7CbG93Mei0uCwIrhj303LSvUd3mxql9KiLpIBaOQYb+ysQFZLzn/N/ABxw7MA
 CfsNcmFQuvfaESnv362iUOIeC1FC9DLVBSVSfZD4yvLAsP9qrev10NZuHpZn4hMbxInyz4jeVid
 On0OleiqSWzirSewmZywLkVJ+3QCJBqdem2iCB61lZua6dy6wZ48m60U9MzLgfoG1DCQHhBhKm1
 MaoZAS3TmZd2nL0gBl+rJ53ClgPgyBj3+QS5XEcr8He0ICjL8/HdebWiDyJcLnXnFAIIPgJFglC
 oCJTovbGYCmEMfxeEMup6MNcSvUMcXIhmQ36+6BU3aiUlxknH5MdyyNGi3TXU80TL6XYJymw7J9
 dCkDsEko7Cgygy07kiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyMiBTYWx0ZWRfX/q90jvpDzJLQ
 WNnzW/bvuhjg1sKd+HGgR0Hq3dORwgTTBfWEKha8wZf4KHbOVMjQGuvb/JpcqAhgJHefwpJJj0F
 z8z/3QIdleKDbsdEJy1ghzETS5WZorY=
X-Proofpoint-GUID: fDvfhB9ynN30h01ntXj9MYefH7tY4FR5
X-Proofpoint-ORIG-GUID: fDvfhB9ynN30h01ntXj9MYefH7tY4FR5
X-Authority-Analysis: v=2.4 cv=RKwmjIi+ c=1 sm=1 tr=0 ts=6affdc57 cx=c_pps
 a=huDpiCfIbSrux5goTpZe+A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=pGLkceISAAAA:8
 a=r_1tXGB3AAAA:8 a=SQSzIW1m15fZG__ua2cA:9 a=QEXdDO2ut3YA:10
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

T24gV2VkLCAyMDI2LTExLTE4IGF0IDExOjE5IC0wNjAwLCBSeWFuIEJydWUgd3JvdGU6DQpIaSBS
eWFuLA0KPiBUaGUgZmlybXdhcmUgdGFrZXMgInByZXZlbnQgYWxsIG92ZXJsYXAiIGZyb20gYml0
IDEgb2YgYSBjb21wdXRlDQo+IGNvbW1hbmQncyBmbGFnczsgYml0IDIgaXMgRk9SQ0VfVFBVX0NM
Sy4gVGhlIGtlcm5lbCBoYXMgdXNlZCBiaXQgMiBzaW5jZQ0KPiB0aGUgRldJRiBoZWFkZXJzIHdl
cmUgYWRkZWQsIHNvIHRoZSBmaXJtd2FyZSBoYXMgbmV2ZXIgc2Vlbg0KPiBEUk1fUFZSX1NVQk1J
VF9KT0JfQ09NUFVURV9DTURfUFJFVkVOVF9BTExfT1ZFUkxBUC4NCj4gDQo+IE9uIGEgR1g2MjUw
IChNVDgxNzMpLCBhIGNvbXB1dGUgam9iIG92ZXJsYXBwaW5nIGZyYWdtZW50IHdvcmsgZnJvbQ0K
PiBhbm90aGVyIGNvbnRleHQgaGFuZ3MgYm90aCBkYXRhIG1hc3RlcnMuIFdpdGggZXZlcnkgY29t
cHV0ZSBqb2INCj4gc3VibWl0dGVkIHdpdGggYml0IDEgc2V0LCBhIHRlc3QgdGhhdCBoaXQgdGhl
IGhhbmcgb24gZXZlcnkgcnVuIG5vIGxvbmdlcg0KPiBkb2VzOyB3aXRoIGJpdCAyIHNldCBpbnN0
ZWFkIGl0IHN0aWxsIGhhbmdzLg0KPiANCj4gRml4ZXM6IGEyNmYwNjdmZWFjMSAoImRybS9pbWFn
aW5hdGlvbjogQWRkIEZXSUYgaGVhZGVycyIpDQo+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQnJ1ZSA8
cnlhbmJydWUuZGV2QGdtYWlsLmNvbT4NCj4gLS0tDQpQbGVhc2UgaW5jbHVkZSBzdGFibGUgdGFn
IGFzIHdlbGwuDQoNClJldmlld2VkLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGlt
Z3RlYy5jb20+DQoNClRoYW5rcywNCkJyYWplc2gNCg0KPiBGb3VuZCB3aGlsZSBjaGFzaW5nIEdQ
VSBoYW5ncyBvbiBhbiBNVDgxNzMgdGFibGV0IChHWDYyNTAsIEJWTkMNCj4gNC40MC4yLjUxKSB1
bmRlciBNZXNhJ3MgUG93ZXJWUiBWdWxrYW4gZHJpdmVyOiBhIGNvbXB1dGUgam9iIHJ1bm5pbmcN
Cj4gbmV4dCB0byBmcmFnbWVudCB3b3JrIGZyb20gYW5vdGhlciBjb250ZXh0IGhhbmdzIHRoZSBH
UFUsIGFuZCBNZXNhJ3MNCj4gcmVxdWVzdCB0byBzZXJpYWxpc2UgY29tcHV0ZSBuZXZlciByZWFj
aGVkIHRoZSBmaXJtd2FyZS4NCj4gDQo+IFRoZSB2YWx1ZSBjb21lcyBmcm9tIEltYWdpbmF0aW9u
J3MgZmlybXdhcmUgaW50ZXJmYWNlIGFzIGNhcnJpZWQgaW4NCj4gTWVzYSAoc3JjL2ltYWdpbmF0
aW9uL3Z1bGthbi93aW5zeXMvcHZyc3J2a20vZnctYXBpL3B2cl9yb2d1ZV9md2lmLmg6DQo+IFBS
RVZFTlRfQUxMX09WRVJMQVAgMHgyLCBGT1JDRV9UUFVfQ0xLIDB4NCksIGFuZCB0aGUgYm9hcmQg
Y29uZmlybXMgaXQ6DQo+IGZvcmNpbmcgYml0IDEgaW50byBldmVyeSBjb21wdXRlIGNvbW1hbmQg
c3RvcHMgdGhlIGhhbmdzLCBmb3JjaW5nIGJpdCAyDQo+IGRvZXMgbm90LiBUaGUgb3RoZXIgY29t
cHV0ZSwgZnJhZ21lbnQgYW5kIHRyYW5zZmVyIGZsYWcgdmFsdWVzIGluDQo+IHB2cl9yb2d1ZV9m
d2lmX2NsaWVudC5oIG1hdGNoIHRoYXQgaGVhZGVyLg0KPiANCj4gVGhpcyBwYXRjaCB3YXMgZGV2
ZWxvcGVkIHdpdGggdGhlIGhlbHAgb2YgYW4gTExNLg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfZndpZl9jbGllbnQuaCB8IDIgKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfZndpZl9jbGllbnQuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfZndpZl9jbGllbnQuaA0KPiBpbmRl
eCA2ZTIyNDQwMDA4M2EuLjk2N2U5MDNiZGNhNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9md2lmX2NsaWVudC5oDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfZndpZl9jbGllbnQuaA0KPiBAQCAtNzQsNyAr
NzQsNyBAQA0KPiAgICogRmxhZ3Mgc3VwcG9ydGVkIGJ5IHRoZSBjb21wdXRlIERNIGNvbW1hbmQg
aS5lLiAmc3RydWN0IHJvZ3VlX2Z3aWZfY21kX2NvbXB1dGUuDQo+ICAgKi8NCj4gIA0KPiAtI2Rl
ZmluZSBST0dVRV9DT01QVVRFX0ZMQUdfUFJFVkVOVF9BTExfT1ZFUkxBUCBCSVRfTUFTSygyKQ0K
PiArI2RlZmluZSBST0dVRV9DT01QVVRFX0ZMQUdfUFJFVkVOVF9BTExfT1ZFUkxBUCBCSVRfTUFT
SygxKQ0KPiAgLyohPCBVc2Ugc2luZ2xlIGNvcmUgaW4gYSBtdWx0aSBjb3JlIHNldHVwLiAqLw0K
PiAgI2RlZmluZSBST0dVRV9DT01QVVRFX0ZMQUdfU0lOR0xFX0NPUkUgQklUX01BU0soNSkNCj4g
IA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBhZWJiNzI3NDQ3NjQwMzA0MGQ1ODJjNjE0Nzhk
ZjhmNGE3YmY5Y2QzDQo+IGNoYW5nZS1pZDogMjAyNjExMTgtcmJydWUtc3Vlei1wdnItY29tcHV0
ZS1vdmVybGFwLWZsYWctMzY5NWNlYWI5YWI2DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg==
