Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F2606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=ghhwFioS;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=GI4G00Xe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56123112B7A;
	Fri, 23 Oct 2026 12:22:39 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FEC112B09;
 Fri, 23 Oct 2026 12:22:24 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NABlp2651874; Fri, 23 Oct 2026 13:22:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=dLRhJrXrAeBgj3/Wh1B5WCaV6TmIPUW+guUgaz5P+BY=; b=ghh
 wFioSe+p8nimlwVRHtMVc/1+WEOtPPi1L81PNxerm5sDKYwcfUUp/++BY/jNT0ci
 bqlL+mEM8PaixiqdeAe8S9JhPxC6SR5vRu0nZ/Jglbfv37CxnRVJ5vamWm/TjzoV
 fqdLQRKR3pKY1cba22ehaN4sQjO8Xmgr/SyyPKnITs3VDnVy8M3jgKhyX2FZW7gL
 +wOF3H5vR2NLaqVute/M/htAf71pAtAxgzqF2NZ2aMbZVrQa5u1YrLxECJisd4ew
 P5/7abpZmleCTdsQS2tB2DYys1rJVFd9HlFXMD5l+9ss193NqA/dOiUG83QHtZzd
 phkS3v3WxnwrAUsz3hg==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021143.outbound.protection.outlook.com [52.101.100.143])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hf88f9c65-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:22:17 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTnK0F6oZYnquqSb2c+TFgQmGPDwQ5SUDVgxQ6h7Ofqn7eNvfzjGIxYohRSyp5NdtZvfz/Efx7G61HMXHYeRgSNs6xxX4HsCIJRVJa94MStwc8beu+a7wI0iGGgcmjW6YeQIPxak7abRZR6OWTKBfDhV0XNjTIqnhfyybqwg5NvNrf/3sD8Sy5n3vHA+R9vPOoBQ4y4100arS9EzAGCEt2B4uUwAHe4l5/L65hdsiSfwblWsm0tEr9jOKBbP+tThTnzZn+Al3GQRHmpP4dkRboxfHAC2om11Tr4fNq8FeOK0pcT2b9oPPtKJVpEo2HA30hssfyqKvOncd/F0VQ5J9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLRhJrXrAeBgj3/Wh1B5WCaV6TmIPUW+guUgaz5P+BY=;
 b=kZf/NNJOr+Hw4aAtmeM6nFVq3SsGVeP9DZ7L+EUlpFu82J+nMclZ/Yqr2ghH6EtQuF6IB/CJ33QojNHDn1CbVFXg7gtqEdZ3FQtZXFV49SNTb9h6TIGd4TmqOhLzzjJz1/bk2wSGbUDmU/zmmb0IX+LsfdNrXpYrZLhjOem2v1i/Sd4vEe+yC8iyc1CvW6tS1Mh3WCBRaAgkdZwHbMt+G9U+hB0+4QBlteIJIGKQ+oke7zOIcIR503otyh7FlbgsfdJr1F9wlBV88/wzqTtwvfJMBz6AcGMGRHxC2URa4ygBl5Xf9TYjvD83s8rjw96CxGI742eNiPheEYeIQ3vhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLRhJrXrAeBgj3/Wh1B5WCaV6TmIPUW+guUgaz5P+BY=;
 b=GI4G00XegC05RG7Qt+LD0ZPdQHtWegObEaEb+ZZGMMPZeZER4kl2RaeNBlBkQPxEs8+i39qE5HppXwezihenII+Y1Z1SfwK/S5/pP6ytsDcOugWUy3iuJjMVyEo3ilPpnqLG5L17ErmoZ7snrva01CIKSFMo+lRQrfycboR0j6M=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO4P265MB6262.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 12:22:16 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 12:22:16 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2 3/4] drm/imagination: Improve some logging in error
 paths
Thread-Topic: [PATCH v2 3/4] drm/imagination: Improve some logging in error
 paths
Thread-Index: AQHdYf7cVs2GVU+/k0e1lwc38AMOM7cLDkiA
Date: Fri, 23 Oct 2026 12:22:16 +0000
Message-ID: <fd47211fa6d97b1a318dd506abb493470d46ea41.camel@imgtec.com>
References: <20261022-b4-simplify-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com>
 <20261022-b4-simplify-mips-pte-defs-v2-3-ee2402c03a4b@imgtec.com>
In-Reply-To: <20261022-b4-simplify-mips-pte-defs-v2-3-ee2402c03a4b@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO4P265MB6262:EE_
x-ms-office365-filtering-correlation-id: 97f3c594-2ed0-4f10-6b6b-08df31004665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|261022115727099003|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: qFD4W0ORSlpG26dZZ+AFAIuiYR9HThkozY8N3UjsNhJ5aN+a21KnTYtJ5pJLYWuCIBRyqHU0m3y4/2j64g7cLeGL7RS6JFssT6TMpIqFfA3Cytj5a4qi7gZIcPha9NsWHWbqymrBqKO+Dp6/luuYQCiQlXbvJbDSWk0Gs5B5dfHFNfI8Sivs2/CsP1rz20AoAa5XsQVU3j1A4ckBbNtrud8i0vyY49hDm52x41LZhx5VcuUzwbf9EU/vxLd97WmNUZi8IJetYykARQVh6mzoWGN635YsTN4we/xILbMOrg/T87hfLXYTsf6LTM/qexLXlaVvfiZqdszDwNPmFMfJhOSmrGSZfgoGethewUVkPGeJaHqHYGHlmE78fwJ36qtd2ILSB4AQ+ApYAoFYjpK8GgPlr5buBp8/vkN5CTz2/qIj9ypW4uXdxWAuayDKXMKcI7Er+CdDyKIn9VMFiKLNKlPZssyH83+9EgAQfUGvKFKYBlPzazoMei0tLrVKG0OtdveklGKpAaqRqgNYNmboSEQDFbh7mlbex/p0DRKVSLsNPeqYVgLRsC5yJpZACGsfET3EbJMCpZfj5Qetdyh1/bSSj9X/L09sw54mcg0HuiZRbOWeGcbiSrT+HMK/uSJjFOD4u4fw4TE2IWmVh9hAEMR6AKlscnf1FFf2B4/K5PgSTDgtQG/Sz+jFJtCh4c+b55Z7UCNOgPvIZrfDgdrZDEguf0YOQwvayhLjA+UhEQo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022115727099003)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGFBSFZqZ29Bb01SdlR4ekFCWnAzejFxNHRFaityTndaR3lNdmFVOXBlRGQ3?=
 =?utf-8?B?L24xVWJXUWV4RFhnQkZZZEpxM1BoaXlaUmtmS0xFaWhnM2J4M2l3eVZnV3FS?=
 =?utf-8?B?KzZwZDRZM1M2c3JEbFMwTUI1Y1QzYngwSjRad0NTZlVvcmZjd28vZjRDUUJz?=
 =?utf-8?B?UjVWRWdrWU1kT2tWdkdMNE5CQXY3V0RvMUhPdFA3M1h5QTMyWTAxQzZEVTFS?=
 =?utf-8?B?WFVjcGVQVXZncUFnU1M5QU94amlaUkI4bDI5T2hrOCtkSFQxakpkRkY3YUhY?=
 =?utf-8?B?TnAwcC9NUDFJK0hyQlZaUmlibmQydE0zRnJzT1hYUDJ3b3RKcEdqaEpEZVBY?=
 =?utf-8?B?MVZDS2d4bUZnM0I0R1h0NlNhcGRyZnpvY1pTK2xiZ0pRMjNxSWJ6eStPNUpK?=
 =?utf-8?B?ZXJFdG0wYkNva3R0QjJFV2NJN21iOHhlTFc0eHB3dnJ2aDBNZWhnaVVnT0dW?=
 =?utf-8?B?d2hOWDcwU1REWDFvVkNDZ1FMY0ExV3I5TnlGdmQ2K2FEQTAzcURjK2RHMkJv?=
 =?utf-8?B?KzZOd1Z3dnpZNDA0RHR0b0RqY1pZNnpoRUtVRUhhRnJ3MVhlQitvU3JIQjdm?=
 =?utf-8?B?OHlkK3JucDlwMm5oZ1FWRjhIZ2tkNGY1T29kYlpwd1dJUzlwelVvOTV5ODls?=
 =?utf-8?B?N2VnNDEzeHdzWUNUU2R4M3Z5UDdHcHV2WjZwRlllTjM0dkIwRHBaNTRSOSs1?=
 =?utf-8?B?cVpESGYvNWlMY1BmYnp1aXpTcG50a2QyTUtsOW54TmlRSEg0QXI1bGN0aFFw?=
 =?utf-8?B?MzF2VEJjZXNkaDVsWWlDcmRRSytaUDRKN285S1IwN3pRWnFRNk90RS9ZbEIw?=
 =?utf-8?B?K2x5ckJ6ZTBXa1BTcU1OYXNFbGg0ZWVGN0tydVdjNlRmOFBVdVY4MEROZGVk?=
 =?utf-8?B?QjJydWJpNTdFWTl3Q0M2RW05bFU4L09oNnJIdnBLMzJtMHNtZy9nVGhMdjh5?=
 =?utf-8?B?QUZ0UUNCQ1dHa29nTmxwSzhpem1iTlpYYkM3TTNZb1AvNGY5SDlPZE05ZmpG?=
 =?utf-8?B?QmIvUlBKdXRzUGRYMmFjWXpBUjQyd0kyRitPdk9oV0o0eC92RWNZNlJaQjFX?=
 =?utf-8?B?VUl4OWcyQ25UK2NnaEpsbFRtQmdOdlNHcVZWM2Z4Y1J6SENiS2RWakdNdW9S?=
 =?utf-8?B?cXBuSnQranpQQmdSRkNSRFpCR3FsS1pNS1NTeFNib3hWUXVkU21LZ3JiNkhy?=
 =?utf-8?B?VGZsRmpBZjNTR3FiNjJYbzU4Z2ZBSTNhdU4xUWR4NmlhUE1iY1VHVU9hWk04?=
 =?utf-8?B?NHF3a29wZitTV2V2Z3RTczRYOU1mQy9kcGdxTzJOVGZ6Tnc2ZnVrbGNQT0xh?=
 =?utf-8?B?NGx2MzFCK1VKNVdIU3FPT2pyRVdJcXFrOWM0SEpoQzNxTklLVUZyN2wycU9J?=
 =?utf-8?B?K0M0WlRNMmwzNituN0dKNG9FQklZRCtoM0ZZaURnRnpaT1MxYU5ldklNY0Fq?=
 =?utf-8?B?UXNka0UvNmtFS1dVeFZCS3JPQXNuOVE3Ryt6bFM0Yk9Cb1cybTZKcEp2bnll?=
 =?utf-8?B?aWEvR2tiaU1nemYrR29NeUpxV3huTURmbGZyWWVZQnhST2hlVDBzM0FxZDlO?=
 =?utf-8?B?d0dpQWJRNFJpSkxzcVJPR28wc2xnZWQwRnpaRHAxZ2dMTXMrcVAzVnA5NGlo?=
 =?utf-8?B?RXp1ZktlSzQzV0ZMNk5KWjhjOVE2Z1dhMGt5UkhHNnpXcE90Wk1aenBnUUYv?=
 =?utf-8?B?Vmg2dFhGdURaSXlZSlRNTmRjVUR3UGV0RXNXdWxGR1NBbTRFNDlVNEc3TGZO?=
 =?utf-8?B?OC9waVlVaEJwL0VYTFBOM3c0T0hWTWV6ZHZDODRNYnIzOTlvS05OTk1MU1Ey?=
 =?utf-8?B?c0EwaTNPVjU4KzQyV1dnT2Exb2w4RDhqRXFlRDNhZkVOZW1ZaUFQRGhwcWJZ?=
 =?utf-8?B?MG5ySzZhR3RuQ2wxdCs3U3hGaGxPUUdFNzF5Mkt4MjAzN3hWTzhTL3BiM1BK?=
 =?utf-8?B?T3YyUCtuRWlpbmpMeWVQV0w3NUFKUmIya0FzazA3NFQrM1MrYUVhblFrVWpW?=
 =?utf-8?B?U211OFJrWlBjQWpTNnprU2oxR0lyS0F5RkpZdlpCa29HNUY2U2UxdnEzNFI5?=
 =?utf-8?B?elNSNUtVdFBiVitrMG9iQ3ZKSXc3L1hTWjFHb0pTT0NCZTZZUDZySmllc0o3?=
 =?utf-8?B?WEZ5bkl3eGNSS1pPWGdjR2JSNTJVL1F3ZER3K09DdkxZTzNja2VQelE1SWRi?=
 =?utf-8?B?ZG1Wdk9KUmRzY04zaGdhZVQ2Sk9GUUF3cURGNjd2ZmlZNHA5ZG94NXJ6RjBR?=
 =?utf-8?B?U1l5UVFpUW5IaG9seDd1dkpERW5CMkYzS2dqUkFTR0VqRUtkdVVQdkhFU2oy?=
 =?utf-8?B?U1hVTG9pdUtpa2ZzUXVPMm5sSmNHVlphS0dHcmJxanhoa0VYQ3YvQytmZjFT?=
 =?utf-8?Q?XhonoWNdCSL7VJ3A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6867FD5185BEBE44B7172DC238281733@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tVUq1Z1Dkza4xrVfU0kmHTgeT4DWPkjoIabmA9olRdRtBnNFleItyZ0Kv6vEz0SRLGaUTXhKKVZ/uqc470I4Tf/e/f0kUZnOU5BzCo2WZNNbUHHzKRGpTno2Or+aDTN+iFZlm9VI7ggQUrRAB4T5jpwd7Uqb0F5qUNRX08BnSvY3lx4zi4vZz/PVQEHfjoEdVeDkW7T/Fqid3PrG1bERYNN1Feq8l1FLwiNI80Rrzjx3R9kgnhgjrLnKy481cLYB518Hz+y0j5LhyhL2o1AhgWCqKwtGWBZLZObIQ8Pqz7cZcWFzUqeFALQL2NnHs2B0sWg5gRzdOXyoGy8qEYC8bw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f3c594-2ed0-4f10-6b6b-08df31004665
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 12:22:16.0629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYrWewxILSuPVr+gtKNmdUhO1StEH7tyya+uUWaSW5K/Zd42r9gsCWTs5H+dGdfX6Nm7s3PxkWdAWtFZfEHZwuGW4l/rBL3YWBqINoG8LT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6262
X-Proofpoint-GUID: nEVSAjSEoI1gMpyLRCUW3eFoOWJSB8eq
X-Proofpoint-ORIG-GUID: nEVSAjSEoI1gMpyLRCUW3eFoOWJSB8eq
X-Authority-Analysis: v=2.4 cv=e7+T2qp/ c=1 sm=1 tr=0 ts=6adb5179 cx=c_pps
 a=ryaCr3KHpNWBLMFLk+OkCQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=0KerVSl3bu9IuEGnA-UA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX13wG2eBveLO6
 3P6BWbRP1ljsEc2MbAkpbmskhXi4Z3rbXjP33jXqwS3Ar5nF+qlICu8k59OhiGpTw0mHpQbXN9Q
 I8Lsu6t84Furm2/v4PYA7fS6vRFQnYI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX3r+R9eBLNHlY
 FjUetjJ9SYDGHhdRWg6edhNnezJDdj/6V3dTI4+0bhwk4OD0MkbXvs0RkiCgt8CHYA1C0jMNnyb
 ByBnXHf6C6DwaXCPv+EfRywxoPS3Lcl11yYkoJ/jVO6mK51Fy+fDT03QvldLlN2G4hCwEra44hX
 Qp1WyqDYClpQFuG4JipZ7nALYqQ72/vtacqdPd1n8GvhIliw0x1jB570dUMOW17gmeRfQ8iuffK
 IVWcz2xry9Xf1ycQh9XLd2Bb9OXDvWNcdO9vDBD5n8XI5Qo2Z8Aj95HZPUR82o7qppCM5O1od/8
 vHypalt3RQXk5oR+wu/vtHU2bMOxaoYPdyd6BnsEz5iNDDylGM2JXlS4R4z1Gyr9w0DwdzNj0yT
 Zg2wQb3QwnUSEqWQCFEgjp4HIsZXkJLOAIjt0T9fp3xFqRRlclVAFyvpMn/w6CWrh3h6vJ0c9k2
 o9ffG3JoBf5ua38FVHw==
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

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDExOjI0ICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gRnJvbTogTWF0dCBDb3N0ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQo+IA0KPiBBZGQg
ZXJyb3IgbWVzc2FnZXMgZm9yIGF0dGVtcHRzIHRvIG1hcCBhbiBhbHJlYWR5IG1hcHBlZCBmaXJt
d2FyZQ0KPiBvYmplY3QsIHVubWFwIGFuIGFscmVhZHkgdW5tYXBwZWQgZmlybXdhcmUgb2JqZWN0
LCBhbmQgcHJvdmlkZSB0b28gZmV3DQo+IERNQSBhZGRyZXNzIHNsb3RzIGZvciB0aGUgZmlybXdh
cmUgcGFnZSB0YWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgQ29zdGVyIDxtYXR0LmNv
c3RlckBpbWd0ZWMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFu
ZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNz
aW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jICAgICAgfCA2ICsrKystLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bV9taXBzLmMgfCA3ICsrKysrKy0NCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMgYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gaW5kZXggYzZjNzdiMTUyMzQyLi40ZjJi
NWM0ZGY2MDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
ZncuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gQEAg
LTExNjUsOCArMTE2NSw5IEBAIHB2cl9md19vYmplY3RfZndfbWFwKHN0cnVjdCBwdnJfZGV2aWNl
ICpwdnJfZGV2LCBzdHJ1Y3QgcHZyX2Z3X29iamVjdCAqZndfb2JqLCB1DQo+ICAJc3Bpbl9sb2Nr
KCZmd19kZXYtPmZ3X21tX2xvY2spOw0KPiAgDQo+ICAJaWYgKGRybV9tbV9ub2RlX2FsbG9jYXRl
ZCgmZndfb2JqLT5md19tbV9ub2RlKSkgew0KPiAtCQllcnIgPSAtRUlOVkFMOw0KPiAtCQlnb3Rv
IGVycl91bmxvY2s7DQo+ICsJCXNwaW5fdW5sb2NrKCZmd19kZXYtPmZ3X21tX2xvY2spOw0KPiAr
CQlkcm1fZXJyKGZyb21fcHZyX2RldmljZShwdnJfZGV2KSwgIkZXIG9iamVjdCBpcyBhbHJlYWR5
IG1hcHBlZCFcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCj4gIAlpZiAo
IWRldl9hZGRyKSB7DQo+IEBAIC0xMjMyLDYgKzEyMzMsNyBAQCBwdnJfZndfb2JqZWN0X2Z3X3Vu
bWFwKHN0cnVjdCBwdnJfZndfb2JqZWN0ICpmd19vYmopDQo+ICANCj4gIAlpZiAoIWRybV9tbV9u
b2RlX2FsbG9jYXRlZCgmZndfb2JqLT5md19tbV9ub2RlKSkgew0KPiAgCQlzcGluX3VubG9jaygm
ZndfZGV2LT5md19tbV9sb2NrKTsNCj4gKwkJZHJtX2Vycihmcm9tX3B2cl9kZXZpY2UocHZyX2Rl
diksICJGVyBvYmplY3QgaXMgYWxyZWFkeSB1bm1hcHBlZCFcbiIpOw0KPiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gIAl9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfdm1fbWlwcy5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bV9t
aXBzLmMNCj4gaW5kZXggODRlMDIzZmZmZTVhLi40MDQ5NWIxNDg2YTIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm1fbWlwcy5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm1fbWlwcy5jDQo+IEBAIC0xMSw2ICsxMSw3IEBA
DQo+ICAjaW5jbHVkZSAicHZyX3ZtX21pcHMuaCINCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kcm1f
bWFuYWdlZC5oPg0KPiArI2luY2x1ZGUgPGRybS9kcm1fcHJpbnQuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9kbWEtbWFwcGluZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4NCj4gQEAgLTI3OCw4ICsyNzksMTIgQEAgcHZyX3ZtX2dldF9wdF9w
aHlzX2FkZHJzKHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2LCB1NjQgKnBoeXNfYWRkcnMsIGlu
dCBtYXhfbnUNCj4gIAlzdHJ1Y3QgcHZyX2Z3X2RldmljZSAqZndfZGV2ID0gJnB2cl9kZXYtPmZ3
X2RldjsNCj4gIAlzdHJ1Y3QgcHZyX3ZtX21pcHNfZGF0YSAqdm1fZGF0YSA9IGZ3X2Rldi0+cHJv
Y2Vzc29yX2RhdGEubWlwc19kYXRhLnZtX2RhdGE7DQo+ICANCj4gLQlpZiAoQVJSQVlfU0laRSh2
bV9kYXRhLT5wdF9wYWdlcykgPiBtYXhfbnVtX2FkZHJzKQ0KPiArCWlmIChBUlJBWV9TSVpFKHZt
X2RhdGEtPnB0X3BhZ2VzKSA+IG1heF9udW1fYWRkcnMpIHsNCj4gKwkJZHJtX2Vycihmcm9tX3B2
cl9kZXZpY2UocHZyX2RldiksDQo+ICsJCQkiTWluaW11bSAlenUgcGFnZXMgcmVxdWlyZWQgZm9y
IEZXIFBULCBidXQgb25seSAlZCBETUEgYWRkcmVzcyBzbG90cyB3ZXJlIHByb3ZpZGVkXG4iLA0K
PiArCQkJQVJSQVlfU0laRSh2bV9kYXRhLT5wdF9wYWdlcyksIG1heF9udW1fYWRkcnMpOw0KPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICANCj4gIAlmb3IgKHUzMiBwYWdlX25yID0gMDsg
cGFnZV9uciA8IG1heF9udW1fYWRkcnM7IHBhZ2VfbnIrKykgew0KPiAgCQkvKiBGaXJtd2FyZSBl
eHBlY3RzIDRrIHBhZ2VzLCBidXQgaG9zdCBwYWdlIHNpemUgbWlnaHQgYmUgZGlmZmVyZW50LiAq
Lw0KPiANCg0K
