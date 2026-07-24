Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE21C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE36886A4;
	Fri, 24 Jul 2026 14:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="PB1BRWkD";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="lwg+K9vj";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B2C886A4
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:51:00 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODe23i749363; Fri, 24 Jul 2026 15:50:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=z/otQGUW9bb1HwkZ2WDj+JnrZSgmHevMSe1QRhgtiJQ=; b=PB1
 BRWkDYwBPobCwQ88bTS7CXWetKP0cxfbzOLsNcSWjl5+l2Sjyc3jlYxO02rIO3V3
 Vphkb5S7+wbs09UcYZ3kxXe4BIF9PdHEHBEEU+6mOZ7VR7RQ5c0IzZ+cV/aercuV
 3YBHYUjejVoA13C0yuaZ1n+SkwanhWyiIcjG/+FCXPd9P0d8W2X2p2j+b7v2pJU6
 ebxfXP39NLmUg2utDqpSnhwVy9Ay2iQYvNt3ZPlYb90qJRTahP3TZoZFmH7Pq2OA
 NoFvNj8MooIIXheCwDpQ54nwMb7uh1sVH+fT4NY0rZgK7ZNNLZqNklgDX9cM3gxF
 00DqUOhugQ+Esml4lBg==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021124.outbound.protection.outlook.com [52.101.95.124])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fhmy1khyw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 15:50:58 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTPAjE+Y1kY7jo8uhRP4RocCaKRBgYt2uKgZWbe86jutPN88Zdfk1Ftn8I71DqOIT0FAv7ANAIk7X1F95N/tfhMrkeSSYtKlhDkLu1lhy/pNIWB/sEqHgCTXsMg59l+QMq+ZUMUJnmSg0E2XaDVwc7paoHRnBcyp07pvk+8u3DBpCaIn70PD7G2+a189FsWLXXMP7fV2ri5OK+urxioznjgglom61xMcsuSGCWrS8fs66nWZs3QfAZa7Ty7jLB+a7f7cWHIchyzPugstHGXXRUIwGinyiHHiIIfjksoPveg/KEpdiiHlnffBVZpo7aiVRpAW21eiYuNqp/GkG30MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/otQGUW9bb1HwkZ2WDj+JnrZSgmHevMSe1QRhgtiJQ=;
 b=Yri8iiVD8JPiH0fx51QG6TlcioUCvuyoUvoRAMddspjK89PVnupHriaETUEABZ5jvqzD6LqmNFSWS9QeCo1mc4n/myZQOK3EV6bddLwXD1QTwR/h5F3rj+wjRW10bCeIacFW42yLWJ7LFon8J1+wgM5+uAQNR7Nv//PlNj/XjJpNNXuD3P/s1CRLZDhgEnJ2tAocqG5tqb+iO/sI1Jx1g1w6XkY5hyi+yFtPO7pA8rvDJyx+QFyicLAy0MtRl+4wO9hdtOgcYm8qfad30Rje0WeLbmK7Ls9wetSQc7G0TQF8ReK4UKtweQ/CwiCUEAO4a8Stg7SFFtzMU0gW2YtPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/otQGUW9bb1HwkZ2WDj+JnrZSgmHevMSe1QRhgtiJQ=;
 b=lwg+K9vj29AsUPdY5bGGXj/NQByR0P/toQbI70chncnpRkMjQAnx1DuEpR0KjCepcM/dw5i57q5PGGfF+jer2es2ozV2xRKPRVfxCh4LjHfT+vNO+QdB15uvqhkEq4t7s/FK5E8/1MJJxrDso8aFIOtN1eLbuGMJOf8ReJ1WzwI=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB1702.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 14:50:55 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:55 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "baihui.liang@spacemit.com" <baihui.liang@spacemit.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Frank
 Binns <Frank.Binns@imgtec.com>, Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luigi
 Santivetti <Luigi.Santivetti@imgtec.com>
Subject: Re: [PATCH] drm/imagination: allow probe when no power-domains are
 described
Thread-Topic: [PATCH] drm/imagination: allow probe when no power-domains are
 described
Thread-Index: AQHdGOGVLUbrmCrVa0yZ7HNGRHuG9bZ8xeWA
Date: Fri, 24 Jul 2026 14:50:55 +0000
Message-ID: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
References: <20260721014919.650943-1-baihui.liang@spacemit.com>
In-Reply-To: <20260721014919.650943-1-baihui.liang@spacemit.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB1702:EE_
x-ms-office365-filtering-correlation-id: 61597a53-b78b-4aa1-49fe-08dee992f734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|5023799004|22082099003|18002099003|56012099006|6133799003|38070700021|10067099003;
x-microsoft-antispam-message-info: xq23YTLUpxqvSTChrd1LFtzpvAxwwtwbuF57W8BI2sPwFp9M+4SGiCHbGWQ1w/kEWkcsdGPh37s8i5CZx5Rwpxe3WCCZXaC7L139/PsnqdnqC6YNs1fVe6ff9psvoGkPnnVS56GMDIwci4qa/WxPoepbkju7SyNFH7m/c0Uv6/wnzJUyWgkOP9gSFfuEeSicd/AKTHhvG6vTvgpaI3s2T8lMzbcMR81Bo0GLEQ6NRQb1QETzDWAqW/haTPjyra18wHleiCvAtXUOEitxoUjoLjC5LHn8oPXJj9uMN4QqyTyJM/QuSc3OFMpiQzBU2EltiVbeZOVro5xzRGUq+74wj7o4CbFS0y/Kg2mPFSGFKzUcAqXnPbSbR7L5FFUwE2uNeOZSs7Kr37XIKPYXWnCC5B6d42mvUDFFVuySizwF6qRm5IN66nHWiNu7YtjlQtlxaIuuF34mwQwAS4Om8CZamb0RITvFFoifq4ZGLgHNyLKLMjBYdR0U1APXB2VUpbBcwpa181f/flEdKXe/Gi5kInLwAdmcWMBtqDAk6aEGC525H2BL0rhadpckCXanqA31ISICi/9A43xBBysoWU12pg1AYPSGXB5d8DNm6EjUYgJSv+INiXSNsqY/R9ABGMUX5KovVE/XanaW3htZ+qoudJDMs9G5TRs8cQirSQbF5Uli8Jso11wR4XQG+PHAlSuGXKLYfvEmHThM9S7Q5zXwAvk+BsK2BcXsKtHyPMyTtp8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(5023799004)(22082099003)(18002099003)(56012099006)(6133799003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEdyNkl6ZDlRbEszSEpkZ2d1VTJ3MkE1WWtmaFVTa0d4WENoc3Z0TzRxdE5R?=
 =?utf-8?B?ajNEWDMrTTN3MFo4Vlc3REZJSERtMTlVM095S0RYc21tWjl0R25LbHk4ZmJl?=
 =?utf-8?B?TlRCZDcyOEloS2tETDVnRnB4Tnh6NDl5Nlp6c1ZOTjBMRVlMRWVzeUtKYXRk?=
 =?utf-8?B?bVFkRmJpcXZxTmQwY1ZJWVo2UkJ0bHQzWnZXVE1HZ3BMdmpaZ0VSTzBpMEVX?=
 =?utf-8?B?TGoreC8ybEkwWTFWWnV3cDg0UFNEN3AxOGhjaDkwRGpBdGRKb1N4Q2VYV3BE?=
 =?utf-8?B?QU5YZkhkejdvZm5JaDRLVC83dG9QSENOU2ZEN2c1L1pLdERkbDFqM25NSERQ?=
 =?utf-8?B?bHJidzNQRGovMW9lWDBwRUh6MU5VSGhpWmhqM0x0cUlab2pYUnBKVm5HcHNj?=
 =?utf-8?B?Y1VyeDkxandIMTlHZGhBUS9PQS9nQ2ZFUUlVd0ZPRm02WHBQVklMcFlvYVd4?=
 =?utf-8?B?QjBFRnNTSW9XVk1mYjY1Zm1xSHBaWnV3by9pVk9wOHRmSEg5MHp2MER2bjlz?=
 =?utf-8?B?aW9hTDZsZDZ2YkVGamMxYXZUNEVIamE4bGRUUFNTYTN4QTVZRHYvbmRLWEYy?=
 =?utf-8?B?VUwrZCtZK1JkUjJWdzRIOTdxTFJ5Y0pINWU4NzFxZk95Q1p0eENiWjEyY09t?=
 =?utf-8?B?WGpSSE9mK3BuQXJ5UEJBamJKbEJiOHNkZGlFTElQeHJoUWV2UzJCbE9uR3VY?=
 =?utf-8?B?RlFEclZVUG1QTE9ETThWWlFkR01TRG04dGttZk8rRTN0RnJ5MDVIV2s1ejhD?=
 =?utf-8?B?WUFuWHl1TG8zTTRUSWhkT3Y1RjB4bzdhNFhZUkQ4UUhqVTFxaHd0OE90MTB4?=
 =?utf-8?B?bEJNOVQwTnFqb2Jab04vT1kvNkRyS1ZZcTdaVW5qMndxSGxNN3cyMkhsbi8v?=
 =?utf-8?B?T2VCejhVcGhBNGJ4ZWdOS1hGWEloNTNickZvM0Y1RVl3WTBWb1VJbmwwTFc2?=
 =?utf-8?B?SnZQM2pDa0N3akUyNTlMM0RDSHF0NEZYOThHWW5MWXFST0NOM0tuTjU4ZDZ3?=
 =?utf-8?B?VkJFeldNOG9wUkhpMlhaTWt6cWE1WE52d2J4SWwxQy80eXlzdDJVWWZweG1K?=
 =?utf-8?B?bWh3WFFhcVZ6dmRxcVRSWXZpY3l4MjZIS0lOVXFrT2JLZVcrMi8rOEdJeUJr?=
 =?utf-8?B?djJqUFh0aDhtT1Q0YWMrOVBUSEhtNHFBcVpiRU9PRVpzb0ZETnA3Z0V5cTgw?=
 =?utf-8?B?dGI5bVowQnRBYUZBR1BzbzR2bFYyUE5XZU1jWW9MNDZsMG1leDlJeDhIY0Z5?=
 =?utf-8?B?UDhMeUdDbjBqNjI4Z1B3dHJDMno3Z2xTUElJWkpKd3VqcmU3VUIyM1JEZjRl?=
 =?utf-8?B?NzAxNTZPS1NNa2Z2U1dQQ1dWMHpRMGtiZlZSdHEzZldUSC9nWHl0dEJ5QXc1?=
 =?utf-8?B?WXl0TWptVHRoYUovU1ljMTlPZSswU0xzZGlDQmpreS9oRXNLdnIvY2toMWpM?=
 =?utf-8?B?WFcxYzk1cnZ2aGJSUVpzaTRyZ1hRMTBZc0o0NHVHWTVqVVJtM3FvcmQ2d3d2?=
 =?utf-8?B?Y0hIakFmNkR6RWNoa1VDeXM0K0NrUVVDYkhSZmMrdE14dFBNS1RnTHRxcFl2?=
 =?utf-8?B?bnJSZVA4M293ZFRFcFF2cHM0NE1uWEI4K2Nhb09Pb29OOFR3bUNTNUc5ZFN6?=
 =?utf-8?B?ZXlXM0lScHFncmNabmd0STUvaWoyOWd2RE9iSDkrVUpMdEI3ZDVtM0E5SFR3?=
 =?utf-8?B?SG8zc1lNR2llWDRmbUtsNThtMVdaU1h4ZlR1S3JJUWY0ZGtuU2tMUkRzdWtZ?=
 =?utf-8?B?aVNuQVBMZ1UwS1ArSnBmWTJVMkNUVkhGOEhSYmNNQmNyY281bTJ0SG1RVE04?=
 =?utf-8?B?YTBQNEhWNFRxSEhpOEZXalBUVmRkdklkbjV1L0JYLzRvcFV1UWRCcFNveWE0?=
 =?utf-8?B?T0wwbDc0RWhhcDJOeWRMUzBHT0VnVlVSU0Q4NlZqM3ZsZnJvcHE2SWtNN1JW?=
 =?utf-8?B?Q1JzUXQ3TlgyVGVmZHlYVWxGdGNSSGdxNGZIYTlySDdEdUxSOHc1cTZuMW9q?=
 =?utf-8?B?MVJKaXBMazZoMU1UM09Ob3FDSXZ1TWF2dUp6MmFJZFMvYzlmNEIxSWhuODRv?=
 =?utf-8?B?RVBvZElpSEFVS0tUalJmTmljdnk3M0JoTkt5akk1ZmJaTTFtbEQvK0I0NmpT?=
 =?utf-8?B?QnpHV0RRUnpyL25OL0MzdmlkSUNDR3NCT1Ywc2QvNEk2V0NGdDZEVit6VnJK?=
 =?utf-8?B?Z3RvRjF6b2hhdWRyR3J2K1lUU2NGUk1oSFZoTSs2RGI3UWZSTjloZ1ZsbEwr?=
 =?utf-8?B?N0ZDQzVNMFMyL2VXVkxuWlNzRk9Lck51VFlhTEhmOFR6M2xGUlNOUlJ1MGZ5?=
 =?utf-8?B?V1laM1N2eklibVd4VzVjVjB3WmlkSTkwQnIyb0c4T3NMaVczQ3dIa0JqSDEv?=
 =?utf-8?Q?2NunBcG+w2Om+/Hs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <854E0D298E70C84B8CCE36C7343C6C3E@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h/TC3Nyeb9w0eJwJGZwrt8/brhasVA681zX1Gg+PX6BrCVAUVwgjblK8qJj+vNVKDkaHqk3SEORUO4UY11XzvVW8WplVm5efa2ea5Z1zuu5AfyPhBtCCxF5wd21NrtKEzCiExRGCf7cyxzTrBu2dgOwmbRDfx07PFaXpBeQanfX2xGUn/meF6Fqh/J1FdQIuXpjYEq0ADhTsvSl3efDkYqB9+budQ5vK0RBkdaCBiscpp2V8kdGT5opvGSRHZ9UfDytDzWEg3cimo/3nG4vYZVSjmfn5iIRI8PxatvAPQI4mZogT4oFJ7odBif2LrEkwMSk0Jjx2OT5ozD7SM52k2g==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61597a53-b78b-4aa1-49fe-08dee992f734
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 14:50:55.4840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+gOLzXm1HvLRZgE58RZKiFN1jiy3bx9YBJ6DJNP0+XY3G6mO/vgmHHjD5co1/hGBEglhaUDjMw1U9QsWBHB+Y2dkHcnMk/RgfazRNRjVoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB1702
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzMyBTYWx0ZWRfX5qFJexU26all
 DclFrNwQaRj4DvA0Sht0yqpDMcbOMVAQ9EUWmtOpGTCnJwNVs5ZxCakULcQRRz1b7hko8oF7LYO
 k/V/1NXE1KaVeatud5pVpcFxN3yQuhxHD9sO+B1GWVAvq7dUr+yppqgxsUWRtRDuFiRKKdGHGX5
 roBRe/admTakgjHELwokqH2vWUnCpQ2QJss0cEp8qu6LiL9vz9/OQAH6lSzStGH6MhgeniF/NGb
 ZbuJMDE5RGEukgGwpnC7S4D76W4XkN3dpV/TkkWoD/+5zI4trRz6MXJ6wJKQSISwLIICxDVimI1
 YlLeLN7rt+zW+Vl//QmQAAyPPPpOKTRxNxMe5ae7odpCxEknwT4Cr2G0uHGoEotxouXb9O7hsDh
 9/PHJvPeLTT6cYqfuukn2yb7u5mbQpCtdNLJYY2oYsdaFlWrGpRu0Shlo2PFtobNkA9CA78rfE4
 I2uTXcXc8f4gGQZiZkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzMyBTYWx0ZWRfX6i87Gdtlziyt
 7WLG0nc9h6cjbV7me5e4bibjRY6BXYz7AkeE0A3t0fCcJPlEkMPHyWNZ6UvKHRIZVj9zT7Gv6Tq
 TqgY7SWAm9hZReK4xNFxszGkmO1+4+E=
X-Proofpoint-GUID: ScTjw4B4vggSSCbun_As2Tktccovsthi
X-Authority-Analysis: v=2.4 cv=YIevDxGx c=1 sm=1 tr=0 ts=6a637bd2 cx=c_pps
 a=O41PMXfrS/GZVastbuJvsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=lv0vYI88AAAA:8
 a=s93QzsrMsku0i0CUVvwA:9 a=QEXdDO2ut3YA:10 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-ORIG-GUID: ScTjw4B4vggSSCbun_As2Tktccovsthi
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

SGkgU3RlcmxpbmctQXNoLAoKT24gVHVlLCAyMDI2LTA3LTIxIGF0IDA5OjQ5ICswODAwLCBTdGVy
bGluZy1Bc2ggd3JvdGU6Cj4gcHZyX3Bvd2VyX2RvbWFpbnNfaW5pdCgpIGN1cnJlbnRseSBmYWls
cyBwcm9iZSB3aXRoIC1FTk9FTlQgd2hlbiB0aGUKPiBkZXZpY2UgdHJlZSBub2RlIGhhcyBubyAi
cG93ZXItZG9tYWlucyIgcHJvcGVydHkuIE9uIHNvbWUgcGxhdGZvcm1zCj4gKGUuZy4gU3BhY2Vt
aVQgSzMpIHRoZSBHUFUgcG93ZXIgZG9tYWluIGlzIGJyb3VnaHQgdXAgYnkgdGhlIGJvb3Rsb2Fk
ZXIKPiBhbmQgaXMgbm90IG1vZGVsZWQgb3IgbWFuYWdlZCBieSBMaW51eCwgc28gdGhlcmUgaXMg
bGVnaXRpbWF0ZWx5IG5vCj4gcG93ZXItZG9tYWlucyBwaGFuZGxlIHRvIGF0dGFjaC4KCk91dCBv
ZiBjdXJpb3NpdHksIGRvZXMgdGhpcyBtZWFuIG5vIHBvd2VyIGRvbWFpbiBjb250cm9sbGVyIGRy
aXZlciBpbiB0aGUKa2VybmVsLCBub3QgZXZlbiB0byB0YWxrIHRvIHRoZSBmaXJtd2FyZT8gRG9l
cyB0aGUgcGxhdGZvcm0gc3RpbGwgc3dpdGNoIEdQVQpwb3dlciBhdCBydW50aW1lPwoKPiAKPiBU
cmVhdCBhIG1pc3NpbmcgInBvd2VyLWRvbWFpbnMiIHByb3BlcnR5IGFzICJub3RoaW5nIHRvIGF0
dGFjaCIgYW5kCj4gY29udGludWUgcHJvYmluZywgcmF0aGVyIHRoYW4gZmFpbGluZy4KCkF0IHRo
ZSBtb21lbnQgdGhlIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGlzIGRyaXZlciBpbiBpbWcs
cG93ZXJ2ci1yb2d1ZS55YW1sCnJlcXVpcmUgYXQgbGVhc3Qgb25lIHBvd2VyIGRvbWFpbi4KClRv
IGFsbG93IHRoaXMgYmVoYXZpb3VyLCB0aGUgYmluZGluZ3Mgc2hvdWxkIGZpcnN0IGJlIHVwZGF0
ZWQgdG8gZHJvcCB0aGUKbWluaW11bSByZXF1aXJlbWVudCBmb3IgdGhpcyBTb0MvcGxhdGZvcm0g
d2hpbGUga2VlcGluZyBpdCBmb3IgZXZlcnl0aGluZyBlbHNlLAp3aGljaCBpbiB0dXJuIHJlcXVp
cmVzIGEgbmV3IGNvbXBhdGlibGUgc3RyaW5nIGZvciB0aGlzIFNvQy9wbGF0Zm9ybS4KClRoZSBT
R1ggYmluZGluZ3MgKGltZyxwb3dlcnZyLXNneC55YW1sKSBoYXZlIGEgcGF0dGVybiBmb3IgcmVx
dWlyZWQvb3B0aW9uYWwKcG93ZXIgZG9tYWlucyB0aGF0IGNvdWxkIGJlIHJldXNlZCBoZXJlLgoK
VGhhbmtzLApBbGVzc2lvCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFN0ZXJsaW5nLUFzaCA8YmFpaHVp
LmxpYW5nQHNwYWNlbWl0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9wb3dlci5jIHwgOSArKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bv
d2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMKPiBpbmRleCBh
NzFkNWIzNTYwMWUuLjU3NTFlMmQ4MTRiMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
aW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX3Bvd2VyLmMKPiBAQCAtNjM1LDYgKzYzNSwxNSBAQCBpbnQgcHZyX3Bvd2VyX2RvbWFp
bnNfaW5pdChzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikKPiAgCj4gIAlkb21haW5fY291bnQg
PSBvZl9jb3VudF9waGFuZGxlX3dpdGhfYXJncyhkZXYtPm9mX25vZGUsICJwb3dlci1kb21haW5z
IiwKPiAgCQkJCQkJICAiI3Bvd2VyLWRvbWFpbi1jZWxscyIpOwo+ICsJaWYgKGRvbWFpbl9jb3Vu
dCA9PSAtRU5PRU5UKSB7Cj4gKwkJLyoKPiArCQkgKiBObyAicG93ZXItZG9tYWlucyIgcHJvcGVy
dHkgaW4gdGhlIGRldmljZSB0cmVlOiB0aGUgcGxhdGZvcm0KPiArCQkgKiBoYW5kbGVzIHBvd2Vy
IGRvbWFpbnMgdHJhbnNwYXJlbnRseSBvciBhdCB0aGUgZmlybXdhcmUvYm9vdGxvYWRlciBsZXZl
bCwKPiArCQkgKiBzbyB0aGVyZSBpcyBubyBkb21haW4gdG8gYXR0YWNoLiBUcmVhdCB0aGlzIGFz
IG5vbi1mYXRhbC4KPiArCQkgKi8KPiArCQllcnIgPSAwOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQo+
ICAJaWYgKGRvbWFpbl9jb3VudCA8IDApIHsKPiAgCQllcnIgPSBkb21haW5fY291bnQ7Cj4gIAkJ
Z290byBvdXQ7Cj4gLS0gCj4gMi4zNC4xCj4gCj4gVGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNo
bWVudCBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgcHJpdmlsZWdlZCBvciBvdGhlcndpc2Ug
cHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVj
aXBpZW50IG9mIHRoaXMgbWVzc2FnZSwgcGxlYXNlIGRlbGV0ZSBpdCBhbmQgYW55IGF0dGFjaG1l
bnQgZnJvbSB5b3VyIHN5c3RlbSBhbmQgbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkg
cmVwbHkgZS1tYWlsLiBVbmludGVuZGVkIHJlY2lwaWVudHMgc2hvdWxkIG5vdCB1c2UsIGNvcHks
IGRpc2Nsb3NlIG9yIHRha2UgYW55IGFjdGlvbiBiYXNlZCBvbiB0aGlzIG1lc3NhZ2Ugb3IgYW55
IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIG1lc3NhZ2UuIEVtYWlscyBjYW5ub3QgYmUg
Z3VhcmFudGVlZCB0byBiZSBzZWN1cmUgb3IgZXJyb3IgZnJlZSBhcyB0aGV5IGNhbiBiZSBpbnRl
cmNlcHRlZCwgYW1lbmRlZCwgbG9zdCBvciBkZXN0cm95ZWQsIGFuZCB5b3Ugc2hvdWxkIHRha2Ug
ZnVsbCByZXNwb25zaWJpbGl0eSBmb3Igc2VjdXJpdHkgY2hlY2tpbmcuIAo+ICAKPiDmnKzpgq7k
u7blj4rlhbbku7vkvZXpmYTku7blhbfmnInkv53lr4bmgKfotKjvvIzlubblj6/og73lj5flhbbk
u5bkv53miqTmiJbkuI3lhYHorrjooqvmiqvpnLLnu5nnrKzkuInmlrnjgILlpoLpmIHkuIvor6/m
lLbliLDmnKzpgq7ku7bvvIzmlazor7fnq4vljbPku6Xlm57lpI3nlLXlrZDpgq7ku7bnmoTmlrnl
vI/pgJrnn6Xlj5Hku7bkurrvvIzlubblsIbmnKzpgq7ku7blj4rlhbbku7vkvZXpmYTku7bku47p
mIHkuIvns7vnu5/kuK3kuojku6XliKDpmaTjgILlpoLpmIHkuIvlubbpnZ7mnKzpgq7ku7blhpnm
mI7kuYvmlLbku7bkurrvvIzmlazor7fliIfli7/kvb/nlKjjgIHlpI3liLbjgIHmiqvpnLLmnKzp
gq7ku7bmiJblhbbku7vkvZXlhoXlrrnvvIzkuqbor7fliIfli7/kvp3mnKzpgq7ku7bmiJblhbbk
u7vkvZXlhoXlrrnogIzph4flj5bku7vkvZXooYzliqjjgILnlLXlrZDpgq7ku7bml6Dms5Xkv53o
r4HmmK/kuIDnp43lronlhajlkozkuI3kvJrlh7rnjrDku7vkvZXlt67plJnnmoTpgJrkv6Hmlrnl
vI/vvIzlj6/og73kvJrooqvmi6bmiKrjgIHkv67mlLnjgIHkuKLlpLHmiJbmjZ/lnY/vvIzmlLbk
u7bkurrpnIDoh6rooYzotJ/otKPlgZrlpb3lronlhajmo4Dmn6XjgIIKCg==
